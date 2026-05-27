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

// p=7, g=2, order q=3
operation TestDLog_p7_g2_x1() : Unit {
    // h=2, g=2, q=3, x=1
    let h = ExpModI(2, 1, 7);
    Message($"h = 2^1 mod 7 = {h}");
    let x = DiscreteLog(2, h, 7);
    Message($"Test p=7 : attendu x=1, obtenu x={x}");
    Fact(ExpModI(2, x, 7) == h, "Vérification échouée");
}

operation TestDLog_p7_g2_x2() : Unit {
    // h=4, g=2, q=3, x=2
    let h = ExpModI(2, 2, 7);
    Message($"h = 2^2 mod 7 = {h}");
    let x = DiscreteLog(2, h, 7);
    Message($"Test p=7 : attendu x=2, obtenu x={x}");
    Fact(ExpModI(2, x, 7) == h, "Vérification échouée");
}

// p=11, g=3, order q=5
operation TestDLog_p11_g3_x2() : Unit {
    // h=9, g=3, q=5, x=2
    let h = ExpModI(3, 2, 11);
    Message($"h = 3^2 mod 11 = {h}");
    let x = DiscreteLog(3, h, 11);
    Message($"Test p=11 : attendu x=2, obtenu x={x}");
    Fact(ExpModI(3, x, 11) == h, "Vérification échouée");
}

operation TestDLog_p11_g3_x3() : Unit {
    // h=5, g=3, q=5, x=3
    let h = ExpModI(3, 3, 11);
    Message($"h = 3^3 mod 11 = {h}");
    let x = DiscreteLog(3, h, 11);
    Message($"Test p=11 : attendu x=3, obtenu x={x}");
    Fact(ExpModI(3, x, 11) == h, "Vérification échouée");
}

operation TestDLog_p11_g3_x4() : Unit {
    // h=4, g=3, q=5, x=4
    let h = ExpModI(3, 4, 11);
    Message($"h = 3^4 mod 11 = {h}");
    let x = DiscreteLog(3, h, 11);
    Message($"Test p=11 : attendu x=4, obtenu x={x}");
    Fact(ExpModI(3, x, 11) == h, "Vérification échouée");
}

// p=11, g=10, order q=2
operation TestDLog_p11_g10_x1() : Unit {
    // h=10, g=10, q=2, x=1
    let h = ExpModI(10, 1, 11);
    Message($"h = 10^1 mod 11 = {h}");
    let x = DiscreteLog(10, h, 11);
    Message($"Test p=11 : attendu x=1, obtenu x={x}");
    Fact(ExpModI(10, x, 11) == h, "Vérification échouée");
}

// p=13, g=3, order q=3
operation TestDLog_p13_g3_x1() : Unit {
    // h=3, g=3, q=3, x=1
    let h = ExpModI(3, 1, 13);
    Message($"h = 3^1 mod 13 = {h}");
    let x = DiscreteLog(3, h, 13);
    Message($"Test p=13 : attendu x=1, obtenu x={x}");
    Fact(ExpModI(3, x, 13) == h, "Vérification échouée");
}

operation TestDLog_p13_g3_x2() : Unit {
    // h=9, g=3, q=3, x=2
    let h = ExpModI(3, 2, 13);
    Message($"h = 3^2 mod 13 = {h}");
    let x = DiscreteLog(3, h, 13);
    Message($"Test p=13 : attendu x=2, obtenu x={x}");
    Fact(ExpModI(3, x, 13) == h, "Vérification échouée");
}

// p=13, g=4, order q=6
operation TestDLog_p13_g4_x3() : Unit {
    // h=12, g=4, q=6, x=3
    let h = ExpModI(4, 3, 13);
    Message($"h = 4^3 mod 13 = {h}");
    let x = DiscreteLog(4, h, 13);
    Message($"Test p=13 : attendu x=3, obtenu x={x}");
    Fact(ExpModI(4, x, 13) == h, "Vérification échouée");
}

operation TestDLog_p13_g4_x5() : Unit {
    // h=10, g=4, q=6, x=5
    let h = ExpModI(4, 5, 13);
    Message($"h = 4^5 mod 13 = {h}");
    let x = DiscreteLog(4, h, 13);
    Message($"Test p=13 : attendu x=5, obtenu x={x}");
    Fact(ExpModI(4, x, 13) == h, "Vérification échouée");
}

// p=17, g=2, order q=8
operation TestDLog_p17_g2_x3() : Unit {
    // h=8, g=2, q=8, x=3
    let h = ExpModI(2, 3, 17);
    Message($"h = 2^3 mod 17 = {h}");
    let x = DiscreteLog(2, h, 17);
    Message($"Test p=17 : attendu x=3, obtenu x={x}");
    Fact(ExpModI(2, x, 17) == h, "Vérification échouée");
}

operation TestDLog_p17_g2_x5() : Unit {
    // h=15, g=2, q=8, x=5
    let h = ExpModI(2, 5, 17);
    Message($"h = 2^5 mod 17 = {h}");
    let x = DiscreteLog(2, h, 17);
    Message($"Test p=17 : attendu x=5, obtenu x={x}");
    Fact(ExpModI(2, x, 17) == h, "Vérification échouée");
}

operation TestDLog_p17_g2_x7() : Unit {
    // h=9, g=2, q=8, x=7
    let h = ExpModI(2, 7, 17);
    Message($"h = 2^7 mod 17 = {h}");
    let x = DiscreteLog(2, h, 17);
    Message($"Test p=17 : attendu x=7, obtenu x={x}");
    Fact(ExpModI(2, x, 17) == h, "Vérification échouée");
}

// p=17, g=4, order q=4
operation TestDLog_p17_g4_x1() : Unit {
    // h=4, g=4, q=4, x=1
    let h = ExpModI(4, 1, 17);
    Message($"h = 4^1 mod 17 = {h}");
    let x = DiscreteLog(4, h, 17);
    Message($"Test p=17 : attendu x=1, obtenu x={x}");
    Fact(ExpModI(4, x, 17) == h, "Vérification échouée");
}

operation TestDLog_p17_g4_x3() : Unit {
    // h=13, g=4, q=4, x=3
    let h = ExpModI(4, 3, 17);
    Message($"h = 4^3 mod 17 = {h}");
    let x = DiscreteLog(4, h, 17);
    Message($"Test p=17 : attendu x=3, obtenu x={x}");
    Fact(ExpModI(4, x, 17) == h, "Vérification échouée");
}

// p=23, g=2, order q=11
operation TestDLog_p23_g2_x4() : Unit {
    // h=16, g=2, q=11, x=4
    let h = ExpModI(2, 4, 23);
    Message($"h = 2^4 mod 23 = {h}");
    let x = DiscreteLog(2, h, 23);
    Message($"Test p=23 : attendu x=4, obtenu x={x}");
    Fact(ExpModI(2, x, 23) == h, "Vérification échouée");
}

operation TestDLog_p23_g2_x7() : Unit {
    // h=13, g=2, q=11, x=7
    let h = ExpModI(2, 7, 23);
    Message($"h = 2^7 mod 23 = {h}");
    let x = DiscreteLog(2, h, 23);
    Message($"Test p=23 : attendu x=7, obtenu x={x}");
    Fact(ExpModI(2, x, 23) == h, "Vérification échouée");
}

operation TestDLog_p23_g2_x10() : Unit {
    // h=12, g=2, q=11, x=10
    let h = ExpModI(2, 10, 23);
    Message($"h = 2^10 mod 23 = {h}");
    let x = DiscreteLog(2, h, 23);
    Message($"Test p=23 : attendu x=10, obtenu x={x}");
    Fact(ExpModI(2, x, 23) == h, "Vérification échouée");
}

// p=29, g=7, order q=7
operation TestDLog_p29_g7_x3() : Unit {
    // h=24, g=7, q=7, x=3
    let h = ExpModI(7, 3, 29);
    Message($"h = 7^3 mod 29 = {h}");
    let x = DiscreteLog(7, h, 29);
    Message($"Test p=29 : attendu x=3, obtenu x={x}");
    Fact(ExpModI(7, x, 29) == h, "Vérification échouée");
}

operation TestDLog_p29_g7_x5() : Unit {
    // h=16, g=7, q=7, x=5
    let h = ExpModI(7, 5, 29);
    Message($"h = 7^5 mod 29 = {h}");
    let x = DiscreteLog(7, h, 29);
    Message($"Test p=29 : attendu x=5, obtenu x={x}");
    Fact(ExpModI(7, x, 29) == h, "Vérification échouée");
}

operation TestDLog_p29_g7_x6() : Unit {
    // h=25, g=7, q=7, x=6
    let h = ExpModI(7, 6, 29);
    Message($"h = 7^6 mod 29 = {h}");
    let x = DiscreteLog(7, h, 29);
    Message($"Test p=29 : attendu x=6, obtenu x={x}");
    Fact(ExpModI(7, x, 29) == h, "Vérification échouée");
}

// p=29, g=12, order q=4
operation TestDLog_p29_g12_x2() : Unit {
    // h=28, g=12, q=4, x=2
    let h = ExpModI(12, 2, 29);
    Message($"h = 12^2 mod 29 = {h}");
    let x = DiscreteLog(12, h, 29);
    Message($"Test p=29 : attendu x=2, obtenu x={x}");
    Fact(ExpModI(12, x, 29) == h, "Vérification échouée");
}

operation TestDLog_p29_g12_x3() : Unit {
    // h=17, g=12, q=4, x=3
    let h = ExpModI(12, 3, 29);
    Message($"h = 12^3 mod 29 = {h}");
    let x = DiscreteLog(12, h, 29);
    Message($"Test p=29 : attendu x=3, obtenu x={x}");
    Fact(ExpModI(12, x, 29) == h, "Vérification échouée");
}

// p=31, g=2, order q=5
operation TestDLog_p31_g2_x2() : Unit {
    // h=4, g=2, q=5, x=2
    let h = ExpModI(2, 2, 31);
    Message($"h = 2^2 mod 31 = {h}");
    let x = DiscreteLog(2, h, 31);
    Message($"Test p=31 : attendu x=2, obtenu x={x}");
    Fact(ExpModI(2, x, 31) == h, "Vérification échouée");
}

operation TestDLog_p31_g2_x3() : Unit {
    // h=8, g=2, q=5, x=3
    let h = ExpModI(2, 3, 31);
    Message($"h = 2^3 mod 31 = {h}");
    let x = DiscreteLog(2, h, 31);
    Message($"Test p=31 : attendu x=3, obtenu x={x}");
    Fact(ExpModI(2, x, 31) == h, "Vérification échouée");
}

operation TestDLog_p31_g2_x4() : Unit {
    // h=16, g=2, q=5, x=4
    let h = ExpModI(2, 4, 31);
    Message($"h = 2^4 mod 31 = {h}");
    let x = DiscreteLog(2, h, 31);
    Message($"Test p=31 : attendu x=4, obtenu x={x}");
    Fact(ExpModI(2, x, 31) == h, "Vérification échouée");
}

// p=37, g=6, order q=4
operation TestDLog_p37_g6_x2() : Unit {
    // h=36, g=6, q=4, x=2
    let h = ExpModI(6, 2, 37);
    Message($"h = 6^2 mod 37 = {h}");
    let x = DiscreteLog(6, h, 37);
    Message($"Test p=37 : attendu x=2, obtenu x={x}");
    Fact(ExpModI(6, x, 37) == h, "Vérification échouée");
}

operation TestDLog_p37_g6_x3() : Unit {
    // h=31, g=6, q=4, x=3
    let h = ExpModI(6, 3, 37);
    Message($"h = 6^3 mod 37 = {h}");
    let x = DiscreteLog(6, h, 37);
    Message($"Test p=37 : attendu x=3, obtenu x={x}");
    Fact(ExpModI(6, x, 37) == h, "Vérification échouée");
}

// p=37, g=10, order q=3
operation TestDLog_p37_g10_x1() : Unit {
    // h=10, g=10, q=3, x=1
    let h = ExpModI(10, 1, 37);
    Message($"h = 10^1 mod 37 = {h}");
    let x = DiscreteLog(10, h, 37);
    Message($"Test p=37 : attendu x=1, obtenu x={x}");
    Fact(ExpModI(10, x, 37) == h, "Vérification échouée");
}

operation TestDLog_p37_g10_x2() : Unit {
    // h=26, g=10, q=3, x=2
    let h = ExpModI(10, 2, 37);
    Message($"h = 10^2 mod 37 = {h}");
    let x = DiscreteLog(10, h, 37);
    Message($"Test p=37 : attendu x=2, obtenu x={x}");
    Fact(ExpModI(10, x, 37) == h, "Vérification échouée");
}

// p=41, g=2, order q=20
operation TestDLog_p41_g2_x7() : Unit {
    // h=5, g=2, q=20, x=7
    let h = ExpModI(2, 7, 41);
    Message($"h = 2^7 mod 41 = {h}");
    let x = DiscreteLog(2, h, 41);
    Message($"Test p=41 : attendu x=7, obtenu x={x}");
    Fact(ExpModI(2, x, 41) == h, "Vérification échouée");
}

operation TestDLog_p41_g2_x11() : Unit {
    // h=39, g=2, q=20, x=11
    let h = ExpModI(2, 11, 41);
    Message($"h = 2^11 mod 41 = {h}");
    let x = DiscreteLog(2, h, 41);
    Message($"Test p=41 : attendu x=11, obtenu x={x}");
    Fact(ExpModI(2, x, 41) == h, "Vérification échouée");
}

operation TestDLog_p41_g2_x15() : Unit {
    // h=9, g=2, q=20, x=15
    let h = ExpModI(2, 15, 41);
    Message($"h = 2^15 mod 41 = {h}");
    let x = DiscreteLog(2, h, 41);
    Message($"Test p=41 : attendu x=15, obtenu x={x}");
    Fact(ExpModI(2, x, 41) == h, "Vérification échouée");
}

// p=43, g=4, order q=7
operation TestDLog_p43_g4_x2() : Unit {
    // h=16, g=4, q=7, x=2
    let h = ExpModI(4, 2, 43);
    Message($"h = 4^2 mod 43 = {h}");
    let x = DiscreteLog(4, h, 43);
    Message($"Test p=43 : attendu x=2, obtenu x={x}");
    Fact(ExpModI(4, x, 43) == h, "Vérification échouée");
}

operation TestDLog_p43_g4_x3() : Unit {
    // h=21, g=4, q=7, x=3
    let h = ExpModI(4, 3, 43);
    Message($"h = 4^3 mod 43 = {h}");
    let x = DiscreteLog(4, h, 43);
    Message($"Test p=43 : attendu x=3, obtenu x={x}");
    Fact(ExpModI(4, x, 43) == h, "Vérification échouée");
}

operation TestDLog_p43_g4_x5() : Unit {
    // h=35, g=4, q=7, x=5
    let h = ExpModI(4, 5, 43);
    Message($"h = 4^5 mod 43 = {h}");
    let x = DiscreteLog(4, h, 43);
    Message($"Test p=43 : attendu x=5, obtenu x={x}");
    Fact(ExpModI(4, x, 43) == h, "Vérification échouée");
}

operation TestDLog_p43_g4_x6() : Unit {
    // h=11, g=4, q=7, x=6
    let h = ExpModI(4, 6, 43);
    Message($"h = 4^6 mod 43 = {h}");
    let x = DiscreteLog(4, h, 43);
    Message($"Test p=43 : attendu x=6, obtenu x={x}");
    Fact(ExpModI(4, x, 43) == h, "Vérification échouée");
}

// p=53, g=4, order q=26
operation TestDLog_p53_g4_x5() : Unit {
    // h=17, g=4, q=26, x=5
    let h = ExpModI(4, 5, 53);
    Message($"h = 4^5 mod 53 = {h}");
    let x = DiscreteLog(4, h, 53);
    Message($"Test p=53 : attendu x=5, obtenu x={x}");
    Fact(ExpModI(4, x, 53) == h, "Vérification échouée");
}

operation TestDLog_p53_g4_x10() : Unit {
    // h=24, g=4, q=26, x=10
    let h = ExpModI(4, 10, 53);
    Message($"h = 4^10 mod 53 = {h}");
    let x = DiscreteLog(4, h, 53);
    Message($"Test p=53 : attendu x=10, obtenu x={x}");
    Fact(ExpModI(4, x, 53) == h, "Vérification échouée");
}

operation TestDLog_p53_g4_x20() : Unit {
    // h=46, g=4, q=26, x=20
    let h = ExpModI(4, 20, 53);
    Message($"h = 4^20 mod 53 = {h}");
    let x = DiscreteLog(4, h, 53);
    Message($"Test p=53 : attendu x=20, obtenu x={x}");
    Fact(ExpModI(4, x, 53) == h, "Vérification échouée");
}

operation RunAllTests() : Unit {
    TestDLog_p59();
    TestDLog_p7_g2_x1();
    TestDLog_p7_g2_x2();
    TestDLog_p11_g3_x2();
    TestDLog_p11_g3_x3();
    TestDLog_p11_g3_x4();
    TestDLog_p11_g10_x1();
    TestDLog_p13_g3_x1();
    TestDLog_p13_g3_x2();
    TestDLog_p13_g4_x3();
    TestDLog_p13_g4_x5();
    TestDLog_p17_g2_x3();
    TestDLog_p17_g2_x5();
    TestDLog_p17_g2_x7();
    TestDLog_p17_g4_x1();
    TestDLog_p17_g4_x3();
    TestDLog_p23_g2_x4();
    TestDLog_p23_g2_x7();
    TestDLog_p23_g2_x10();
    TestDLog_p29_g7_x3();
    TestDLog_p29_g7_x5();
    TestDLog_p29_g7_x6();
    TestDLog_p29_g12_x2();
    TestDLog_p29_g12_x3();
    TestDLog_p31_g2_x2();
    TestDLog_p31_g2_x3();
    TestDLog_p31_g2_x4();
    TestDLog_p37_g6_x2();
    TestDLog_p37_g6_x3();
    TestDLog_p37_g10_x1();
    TestDLog_p37_g10_x2();
    TestDLog_p41_g2_x7();
    TestDLog_p41_g2_x11();
    TestDLog_p41_g2_x15();
    TestDLog_p43_g4_x2();
    TestDLog_p43_g4_x3();
    TestDLog_p43_g4_x5();
    TestDLog_p43_g4_x6();
    TestDLog_p53_g4_x5();
    TestDLog_p53_g4_x10();
    TestDLog_p53_g4_x20();
    Message("Tous les tests ont réussi.");
}
