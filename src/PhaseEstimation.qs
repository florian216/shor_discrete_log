import Std.Math.InverseModI;
import Std.Math.ExpModI;
import Std.Diagnostics.Fact;
import UGate.MultiplyConstantModulo;
operation ApplyUGate(generator: Int, modulo: Int, power: Int, qs: Qubit[]): Unit is Adj + Ctl {
    MultiplyConstantModulo(ExpModI(generator, power, modulo), modulo, qs)
}

operation EstimateFrequency(g : Int, h: Int, modulo : Int, moduloBitSize : Int) : (Int, Int) {
    mutable frequency_a = 0;
    mutable frequency_b = 0;
    let bitsPrecision = 2 * moduloBitSize + 1;
    use qs = Qubit[moduloBitSize];
    X(qs[0]);
    use c_a = Qubit();
    use c_b = Qubit();
    mutable i = bitsPrecision - 1;
    while (i >= 0) {
        H(c_a);
        Controlled ApplyUGate([c_a], (g, modulo, 1 <<< i, qs));
        R1Frac(frequency_a, bitsPrecision - 1 - i, c_a);
        H(c_a);
        let measure = M(c_a);
        if (measure == One)
        {
            frequency_a += 1 <<< (bitsPrecision-1-i);
            X(c_a);
        }

        i-=1;
    }

    i = bitsPrecision - 1;
    while (i >= 0) {
        H(c_b);
        let h_inv_mod = InverseModI(h, modulo);
        Controlled ApplyUGate([c_b], (h_inv_mod, modulo, 1 <<< i, qs));
        R1Frac(frequency_b, bitsPrecision - 1 - i, c_b);
        H(c_b);
        let measure = M(c_b);
        if (measure == One)
        {
            frequency_b += 1 <<< (bitsPrecision-1-i);
            X(c_b);
        }


        i-=1;
    }
    ResetAll(qs);
    return (frequency_a, frequency_b);
}

operation TestEstimateDiscreteLog1() : Unit {
    // p = 7, r = 6, g = 3, h = 4 (secret x = 4)
    // h_inv = 2
    // Echelle Q = 128. Pas de fréquence = 128/6 ~ 21.33
    let (freq_u, freq_v) = EstimateFrequency(3, 2, 7, 3);
    Message($"Fréquence U : {freq_u}, Fréquence V : {freq_v}");

    // v = 2u mod 6.
    let isValid = 
        (freq_u == 21 and freq_v == 43) or  // u=1, v=2
        (freq_u == 43 and freq_v == 85) or  // u=2, v=4
        (freq_u == 64 and freq_v == 0)  or  // u=3, v=0
        (freq_u == 85 and freq_v == 43) or  // u=4, v=2
        (freq_u == 107 and freq_v == 85) or // u=5, v=4
        (freq_u == 0 and freq_v == 0);      // Cas trivial k=0
        
    Fact(isValid, $"Paires de fréquences ({freq_u}, {freq_v}) inattendues ou désynchronisées");
}

operation TestEstimateDiscreteLog2() : Unit {
    // p = 11, r = 10, g = 2, h = 7 (secret x = 7)
    // h_inv = 8
    // Echelle Q = 512. Pas de fréquence = 512/10 = 51.2
    let (freq_u, freq_v) = EstimateFrequency(2, 8, 11, 4);
    Message($"Fréquence U : {freq_u}, Fréquence V : {freq_v}");

    // v = 3u mod 10.
    let isValid = 
        (freq_u == 51 and freq_v == 154) or  // u=1, v=3
        (freq_u == 102 and freq_v == 307) or // u=2, v=6
        (freq_u == 154 and freq_v == 461) or // u=3, v=9
        (freq_u == 205 and freq_v == 102) or // u=4, v=2 (12 mod 10)
        (freq_u == 0 and freq_v == 0);       // Cas trivial k=0
        
    Fact(isValid, $"Paires de fréquences ({freq_u}, {freq_v}) inattendues ou désynchronisées");
}