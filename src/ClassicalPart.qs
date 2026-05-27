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
function LogFromFrequencies(freq1 : Int, freq2 : Int, N : Int, p : Int, g : Int, h : Int) : Int {
    mutable (k, q) = ContinuedFractionConvergentI((freq1, N), p);
    k = AbsI(k);
    q = AbsI(q);
    if q <= 1 {
        return -1;  
    }
    let kx_mod_q = ((freq2 * q + N/2) / N) % q;  

    let inv_k = InverseModI(k, q); 
    if inv_k == -1 {
        return -1;  
    }
    
    let x = (kx_mod_q * inv_k) % q;
    
    let xFinal = x < 0 ? x + q | x;
    
    
    return xFinal;
}

// fct auxiliaire intermediaire entre le solver et le calcul du log
// elle recupere les frequences et les passe a la fonction de calcul du log
operation EstimateDiscreteLog(h : Int, g : Int, p : Int) : Int {
    let bitSize = BitSizeI(p);
    let (freq1, freq2) = EstimateFrequency(g, h, p, bitSize);
    if (freq1 == 0 or freq2 == 0) {
        return -1;
    }
    let bitsPrecision = 2 * bitSize + 1;
    return LogFromFrequencies(freq1, freq2, 1 <<< bitsPrecision, p, g, h);
}

// le solver
operation DiscreteLog(g : Int, h : Int, p : Int) : Int {
    Fact(GreatestCommonDivisorI(g, p) == 1, "g et p doivent être premiers entre eux");

    mutable found = false;
    mutable result = -1;
    mutable attempt = 0;

    repeat {
        let candidate = EstimateDiscreteLog(h, g, p);
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