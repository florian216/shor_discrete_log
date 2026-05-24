import Std.Math.InverseModI;
import Std.Random.DrawRandomInt;
import PhaseEstimation.EstimateFrequency;
import Std.Math.Ceiling;
import Std.Math.GreatestCommonDivisorL;
import Std.Math.GreatestCommonDivisorI;
import Std.Math.AbsI;
import Std.Math.ContinuedFractionConvergentI;
import Std.Math.Lg;
import Std.Math.Floor;
import Std.Math.Round;
import Std.Convert.IntAsDouble;
import Std.Math.BitSizeI;
import Std.Diagnostics.Fact;
import Std.Math.Max;
import Std.Math.ExpModI;

// Appel dans la fonction du solver pour chcek si solutino valide
function VerifyDiscreteLog(generator : Int, target : Int, modulus : Int, candidate : Int) : Bool {
    return ExpModI(generator, candidate, modulus) == target % modulus;
}


// calculs de la Section II.B, page 5
function LogFromFrequencies(freq1 : Int, freq2 : Int, q : Int, bitsPrecision : Int) : Int {
    let N = 1 <<< bitsPrecision;

    // " l = ⌊l'/q · q⌋"
    let l = Round(IntAsDouble(freq2) / IntAsDouble(N) * IntAsDouble(q));

    //" β = ⌊sl'/q · q⌋"
    let beta = Round(IntAsDouble(freq1) / IntAsDouble(N) * IntAsDouble(q));


    if (GreatestCommonDivisorI(l, q) != 1) {
        // l et q no co-prime, circuit quantique à pas fonctionner 
        Message("l and q aren't co-primes");
        return -1; 
    }

    // "linv = 1/l [q]"
    let lInv = InverseModI(l, q);

    // retourne beta/l [q], donc s
    return (beta * lInv) % q;
}

// fct auxiliaire intermediaire entre le solver et le calcul du log
// elle recupere les frequences et les passe a la fonction de calcul du log
operation EstimateDiscreteLog(h : Int, g : Int, p : Int, q : Int) : Int {
    let bitSize = BitSizeI(p);
    let (freq1, freq2) = EstimateFrequency(g, h, p, bitSize);
    if (freq1 == 0 or freq2 == 0) {
        return -1;
    }
    let bitsPrecision = 2 * bitSize + 1;
    return LogFromFrequencies(freq1, freq2, q, bitsPrecision);
}

// le solver
operation DiscreteLog(g : Int, h : Int, p : Int) : Int {
    Fact(GreatestCommonDivisorI(g, p) == 1, "g et p doivent être premiers entre eux");

    //je sais pas si ca marche tout le temps de faire ca
    let q = (p - 1);

    mutable found = false;
    mutable result = -1;
    mutable attempt = 0;

    repeat {
        let candidate = EstimateDiscreteLog(h, g, p, q);
        if (candidate >= 0 and VerifyDiscreteLog(g, h, p, candidate)) {
            result = candidate;
            found = true;
        }
        attempt += 1;
    } until found or attempt > 100
    fixup {
        Message("Repeat")
    }
    return result;
}