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
        Controlled ApplyUGate([c_b], (h, modulo, 1 <<< i, qs));
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
    return (frequency_b, frequency_a);
}