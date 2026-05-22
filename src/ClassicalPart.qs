import Std.Random.DrawRandomInt;
import PhaseEstimation.EstimateFrequency;
import Std.Math.Ceiling;
import Std.Math.GreatestCommonDivisorL;
import Std.Math.GreatestCommonDivisorI;
import Std.Math.AbsI;
import Std.Math.ContinuedFractionConvergentI;
import Std.Math.Lg;
import Std.Math.Floor;
import Std.Convert.IntAsDouble;
import Std.Math.BitSizeI;
import Std.Diagnostics.Fact;
import Std.Math.Max;
import Std.Math.ExpModI;


function MaybeFactorsFromPeriod(
    modulus : Int,
    generator : Int,
    period : Int
) : (Bool, (Int, Int)) {
    if (period%2 == 1)
    {
        return (false, (1,1));
    }
    let h = ExpModI(generator, period / 2, modulus);
    if (h == -1)
    {
        return (false, (1,1))
    }
    let f1 = GreatestCommonDivisorI(h - 1, modulus);
    let f2 = GreatestCommonDivisorI(h + 1, modulus);
    let f = Max([f1] + [f2]);
    if (f > 1 and f < modulus)
    {
        return (true, (f, modulus/ f));
    }
    return (false, (1,1));
}

function TestMaybeFactorsFromPeriod() : Int {
    let (ok1, (a1, b1)) = MaybeFactorsFromPeriod(15, 2, 4);
    Message($"attendu : (true, (5, 3)) car 2ˆ2 mod 15 = 4 got : ({ok1}, ({a1}, {b1}))");
// attendu : (true, (5, 3)) car 2ˆ2 mod 15 = 4
let (ok2, (a2, b2)) = MaybeFactorsFromPeriod(15, 4, 2);
    Message($"attendu : (true, (5, 3)) car 2ˆ2 mod 15 = 4 got : ({ok2}, ({a2}, {b2}))");
// attendu : (true, (5, 3)) car 4ˆ1 mod 15 = 4
let (ok3, (a3, b3)) = MaybeFactorsFromPeriod(21, 2, 6);
    Message($"attendu : (true, (7, 3)) car 2ˆ3 mod 21 = 8 got : ({ok3}, ({a3}, {b3}))");
// attendu : (true, (7, 3)) car 2ˆ3 mod 21 = 8
let (ok4, _) = MaybeFactorsFromPeriod(15, 7, 4);
    Message($"attendu : (true, ...) car 7ˆ2 mod 15 = 49 mod 15 = 4 got ({ok4}, ...)");
// attendu : (true, ...) car 7ˆ2 mod 15 = 49 mod 15 = 4
let (ok5, _) = MaybeFactorsFromPeriod(15, 2, 3);
    Message($"attendu : false got {ok5}");
// attendu : (false, (1, 1)) car r impair
let (ok6, _) = MaybeFactorsFromPeriod(15, 14, 2);
    Message($"attendu : false got {ok6}");
// attendu : (false, (1, 1)) car 14ˆ1 mod 15 = 14 = N-1 (cas trivial)
return 67;
}

function PeriodFromFrequency(modulo: Int, frequency: Int, bitsPrecision: Int, currentDivisor: Int) : Int {
    let n = Ceiling(Lg(IntAsDouble(modulo)));
    let p = 2*n+1;
    mutable (numerator,denominator) = ContinuedFractionConvergentI((frequency, 2^p), modulo);
    numerator = AbsI(numerator);
    denominator = AbsI(denominator);

    let finalPeriod = (denominator * currentDivisor)/GreatestCommonDivisorI(currentDivisor, denominator);
    return finalPeriod;
}

function TestPeriodFromFrequency() : Int {
    let p1 = PeriodFromFrequency(15, 128, 9, 1);
    // attendu : 4 (car 128/512 = 1/4, période 4)
    Message($"4 = {p1}");
    let p2 = PeriodFromFrequency(15, 256, 9, 1);
    // attendu : 2 (car 256/512 = 1/2, diviseur de 4)
    Message($"2 = {p2}");
    let p3 = PeriodFromFrequency(15, 384, 9, 1);
    // attendu : 4 (car 384/512 = 3/4, période 4)
    Message($"4 = {p3}");
    let p4 = PeriodFromFrequency(15, 0, 9, 1);
    // attendu : 0 ou 1 (cas dégénéré ; EstimatePeriod filtre ce cas en amont)
    Message($"0 or 1 = {p4}");
    let p5 = PeriodFromFrequency(15, 128, 9, 2);
    // attendu : 4 (lcm(2, 4) = 4 ; combinaison avec un diviseur précédent)
    Message($"4 = {p5}");
    return 67;
}

operation EstimatePeriod(generator : Int, modulo : Int) : Int {
    Fact(GreatestCommonDivisorI(generator, modulo) == 1, "LE SIXSEVEN A GAGNE SKIBIDI TOILETTETS");
    let bitSize = BitSizeI(modulo);
    let frekensss_kantik = EstimateFrequency(generator, modulo, bitSize);
    if (frekensss_kantik != 0){
        return PeriodFromFrequency(modulo, frekensss_kantik, 2*bitSize+1, 1);
    }
    return 1;
}


operation TestEsimatePeriod() : Int {
    mutable goodPeriodP1 = 0.0;
    mutable goodDividP1 = 0.0;
    mutable badP1 = 0.0;

    mutable goodPeriodP2 = 0.0;
    mutable goodDividP2 = 0.0;
    mutable badP2 = 0.0;

    mutable goodPeriodP3 = 0.0;
    mutable goodDividP3 = 0.0;
    mutable badP3 = 0.0;

    for i in 1 .. 100 {
        let p1 = EstimatePeriod(2, 15);
        // attendu : 4 (bonne période) ou 2 (un diviseur, si la mesure tombe sur s = 2)
        if (p1 == 4){
            goodPeriodP1 += 1.0;
        }
        elif (p1 == 2){
            goodDividP1 += 1.0;
        }
        else{
            badP1 += 1.0;
        }

        let p2 = EstimatePeriod(7, 15);
        // attendu : 4 (bonne période) ou 2 (un diviseur, si la mesure tombe sur s = 2)
        if (p2 == 4){
            goodPeriodP2 += 1.0;
        }
        elif (p2 == 2){
            goodDividP2 += 1.0;
        }
        else{
            badP2 += 1.0;
        }

        let p3 = EstimatePeriod(2, 21);
        // attendu : 6 (bonne période) ou 2 ou 3 (un diviseur)
        if (p3 == 6){
            goodPeriodP3 += 1.0;
        }    
        elif (p3 == 2 or p3 == 3){
            goodDividP3 += 1.0;
        }
        else{
            badP3 += 1.0;
        }
    }


    Message($"Taux de bon pour p1 : {(goodPeriodP1/100.0)*100.0}%");
    Message($"Taux de bon pour p2 : {(goodPeriodP2/100.0)*100.0}%");
    Message($"Taux de bon pour p3 : {(goodPeriodP3/100.0)*100.0}%");

    Message($"Taux de diviseur pour p1 : {(goodDividP1/100.0)*100.0}%");
    Message($"Taux de diviseur pour p2 : {(goodDividP2/100.0)*100.0}%");
    Message($"Taux de diviseur pour p3 : {(goodDividP3/100.0)*100.0}%");

    Message($"Taux de pas bon pour p1 : {(badP1/100.0)*100.0}%");
    Message($"Taux de pas bon pour p2 : {(badP2/100.0)*100.0}%");
    Message($"Taux de pas bon pour p3 : {(badP3/100.0)*100.0}%");
    return 67;
}

operation FactorSemiprimeInteger(n : Int) : (Int, Int) {
    if (n % 2 == 0) {
        return (n / 2, 2)
    }
    mutable foundFactors = false;
    mutable factors = (1, 1);
    mutable attempt = 1;
    repeat {
        let g = DrawRandomInt(1, n-1); 
        let gcd = GreatestCommonDivisorI(g, n);

        if (gcd == 1) {
            let periode = EstimatePeriod(g, n);
            let (success, (factor1, factor2)) = MaybeFactorsFromPeriod(n, g, periode);
            if (success){
                factors = (factor1, factor2);
                foundFactors = true;
            }
        }
        else{
            factors = (gcd, n/gcd);
            foundFactors = true;
        }
        attempt += 1;
    } until foundFactors or attempt > 100
    fixup { Message("Attempt failed, redo") }
    return factors;
}

operation TestFactorSemiprimeInteger1() : Int {
    let (a, b) = FactorSemiprimeInteger(15);
    // attendu : (5, 3) ou (3, 5)
    Message($"(5, 3) ou (3, 5) : {(a,b)}");
    let (a, b) = FactorSemiprimeInteger(21);
    // attendu : (3, 7) ou (7, 3) ou (3, 7) par chemin classique
    Message($"(3, 7) ou (7, 3) ou (3,7) : {(a,b)}");
    let (a, b) = FactorSemiprimeInteger(35);
    // attendu : (5, 7) ou (7, 5)
    Message($"(5, 7) ou (7, 5) : {(a,b)}");
    return 67;
}

operation TestFactorSemiprimeInteger2() : Int {
    let (a, b) = FactorSemiprimeInteger(35333);
    // attendu : (397, 89) ou (89, 397)
    Message($"(397, 89) ou (89, 397) : {(a,b)}");
    return 67;
}

operation TestFactor15() : Unit {
    let (a, b) = FactorSemiprimeInteger(15);
    Message($"15 = {a} * {b}");
    Fact(a * b == 15, "Produit incorrect");
    Fact((a == 3 and b == 5) or (a == 5 and b == 3), "Facteurs incorrects");
}

operation TestFactor21() : Unit {
    let (a, b) = FactorSemiprimeInteger(21);
    Message($"21 = {a} * {b}");
    Fact(a * b == 21, "Produit incorrect");
    Fact((a == 3 and b == 7) or (a == 7 and b == 3), "Facteurs incorrects");
}

operation TestFactor35() : Unit {
    let (a, b) = FactorSemiprimeInteger(35);
    Message($"35 = {a} * {b}");
    Fact(a * b == 35, "Produit incorrect");
    Fact((a == 5 and b == 7) or (a == 7 and b == 5), "Facteurs incorrects");
}