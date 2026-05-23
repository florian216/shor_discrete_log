import ClassicalPart.*;
import PhaseEstimation.*;
import UGate.*;
import Std.Math.ExpModI;
import Std.Diagnostics.Fact;

operation TestDLog_p59() : Unit {
    // p = 59 (premier), g = 2 (générateur, ordre 58 = 2 * 29).
    // bitSize(59) = 6, donc bitsPrecision = 13. 8192 itérations de QPE.
    // Devrait tenir mais c'est costaud.
    let h = ExpModI(2, 25, 59);
    Message($"h = 2^25 mod 59 = {h}");
    let x = DiscreteLog(2, h, 59);
    Message($"Test p=59 : attendu x=25, obtenu x={x}");
    Fact(ExpModI(2, x, 59) == h, "Vérification échouée");
}