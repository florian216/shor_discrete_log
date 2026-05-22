import Std.Math.ExpModI;
import Std.Diagnostics.Fact;
import UGate.MultiplyConstantModulo;
operation ApplyUGate(generator: Int, modulo: Int, power: Int, qs: Qubit[]): Unit is Adj + Ctl {
    MultiplyConstantModulo(ExpModI(generator, power, modulo), modulo, qs)
}

operation EstimateFrequency(generator : Int, modulo : Int, moduloBitSize : Int) : Int {
    mutable frequency = 0;
    let bitsPrecision = 2 * moduloBitSize + 1;
    use qs = Qubit[moduloBitSize];
    X(qs[0]);
    use c = Qubit();
    mutable i = bitsPrecision - 1;
    while (i >= 0) {
        H(c);
        Controlled ApplyUGate([c], (generator, modulo, 1 <<< i, qs));
        R1Frac(frequency, bitsPrecision - 1 - i, c);
        H(c);
        let measure = M(c);
        if (measure == One)
        {
            frequency += 1 <<< (bitsPrecision-1-i);
            X(c);
        }
        i-=1;

    }
    ResetAll(qs);
    return frequency;
}

operation TestEstimateFrequency1() : Unit {
    let frequency = EstimateFrequency(2, 15, 4);
    Message($"Fréquence : {frequency}");
    let isValid = frequency == 0 or frequency == 128
        or frequency == 256 or frequency == 384;
    Fact(isValid, $"Fréquence {frequency} inattendue");
}

operation TestEstimateFrequency2() : Unit {
    mutable count0 = 0; mutable count128 = 0;
    mutable count256 = 0; mutable count384 = 0;
    for _ in 1..40 {
        let freq = EstimateFrequency(2, 15, 4);
        if freq == 0 { count0 += 1; }
        elif freq == 128 { count128 += 1; }
        elif freq == 256 { count256 += 1; }
        elif freq == 384 { count384 += 1; }
    }
    Message($"0={count0}, 128={count128}, 256={count256}, 384={count384}");
}

operation TestSimpleCaseStatistical() : Unit {
    let generator = 2;
    let modulo = 15;
    let moduloBitSize = 4;
    
    mutable count0 = 0;
    mutable count128 = 0;
    mutable count256 = 0;
    mutable count384 = 0;
    mutable countOther = 0;
    
    for _ in 1..40 {
        let frequency = EstimateFrequency(generator, modulo, moduloBitSize);
        if frequency == 0 { count0 += 1; }
        elif frequency == 128 { count128 += 1; }
        elif frequency == 256 { count256 += 1; }
        elif frequency == 384 { count384 += 1; }
        else { countOther += 1; }
    }
    
    Message($"Sur 40 runs: 0={count0}, 128={count128}, 256={count256}, 384={count384}, autre={countOther}");
    Fact(countOther == 0, "Une fréquence inattendue est apparue");
    // Chaque valeur devrait apparaître environ 10 fois (loi des grands nombres)
}