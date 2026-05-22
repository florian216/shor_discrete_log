import Std.Math.InverseModI;
import Std.Diagnostics.DumpMachine;
import Std.Convert.IntAsBigInt;
import Std.Arithmetic.ApplyIfLessOrEqualL;
import Std.Arithmetic.IncByI;
import Std.Math.Floor;
import Std.Math.LogOf2;

operation AddConstantModulo(c: Int, modulo: Int, qs: Qubit[]): Unit is Adj + Ctl {
    
        use carry = Qubit();
        IncByI(c, qs + [carry]);
        Adjoint IncByI(modulo, qs + [carry]);
        Controlled IncByI([carry], (modulo, qs));
        ApplyIfLessOrEqualL(X, IntAsBigInt(c), qs, carry);
}


operation MultiplyConstantModulo(c: Int, modulo: Int, qs: Qubit[]): Unit is Adj + Ctl {
    use aux = Qubit[Length(qs)];
    for i in 0 .. Length(qs)-1 {
        Controlled AddConstantModulo([qs[i]], (c*2^i%modulo,modulo, aux))
    }
    for i in 0 .. Length(qs) - 1 {
        SWAP(qs[i], aux[i]);
    }
    for i in 0 .. Length(qs)-1 {
        let shiftC = (InverseModI(c, modulo) <<< i) % modulo;
        Controlled AddConstantModulo([qs[i]], (modulo-shiftC,modulo, aux))
    }
}

// Mfw I cannot use Reset when a function is Adj

// ⡠⠒⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠉⠙⢦
// ⡇⠀⡔⠛⠲⡄⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣤⠒⠚⢧⡀
// ⠱⣼⠀⢀⡠⠧⠤⣀⢠⠃⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠀⠀⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⣀⣀⡀⠀⠀⣿⣆⠀⠀⡇
// ⠀⢹⢀⡎⠀⠀⠀⢈⠏⠀⢠⠚⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⡾⠟⠛⠛⠛⠻⣶⣶⢤⣀⠀⠀⠀⠀⠀⠀⠀⣯⠀⠀⢱⠀⢠⢧⠛⠒⢦⡇
// ⠀⠈⣾⠀⠀⡔⠋⠁⠀⢀⡏⠀⠀⠀⠀⠀⠀⠀⡠⠞⠛⣋⣀⣀⠀⠀⠀⣤⣤⣀⠀⠈⠙⢦⡀⠀⠀⠀⠀⠈⢣⠀⢸⢀⠞⠸⣄⠀⠀⢱
// ⠀⠀⠘⡆⠀⠃⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⣠⠎⣠⠴⣿⣿⠟⠀⠀⠀⠀⠘⣿⣿⠑⢦⡀⠀⠙⢦⡀⠀⠀⠀⢸⠀⠀⡁⠀⠀⡜⠇⠀⢸
// ⠀⠀⠀⢣⠀⠀⠀⠙⢄⢀⠇⠀⠀⠀⠀⡼⠁ ⠈⠀ ⠈⣁⠴⠚⠉⠉⠉⠙⠢⢄⠀⠀⠀⠀⠀⠈⢣⡀⠀⠀⢸⢀⡏⠁⠀⠈⠀⠀⡰⠃
// ⠀⠀⠀⠀⠣⡀⠀⠀⢸⠋⠀⠀⠀⠀⣸⠁⠀⠀⠀⢀⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀ ⠱⣄⠀⠀⠀⠀⠀ ⢧⠀⠀⠀⠻⣇⠀⠀⢀⡴⠊
// ⠀⠀⠀⠀⠀⠈⠉⠉⠁⠀⠀⠀⠀⢠⡏⠀⠀⠀⢀⠎⠀⢀⣾⣿⣆⠀⣰⣿⣦⠀⠀⠘⣆⠀⠀⠀⠀⢸⡇⠀⠀⠀⠈⠉⠉⠉
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠁⠀⠀⠀⡎⠀⠀⣾⣿⣿⣿⣶⣿⣿⣿⡄⠀⠀⠘⡆⠀⠀⠀⠀⡇
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠸⠁⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⢰⡀⠀⠀⠀⡇
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⠀⢀⡇⠀⠀⠀⢿⠟⠋⠁⠀⠈⠙⠻⡏⠀⠀⠀⠀⣇⠀⠀⠀⡇
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢷⠀⢸⠀⠀⠀⡴⠃⠀⠀⠀⠀⠀⠀⠀⠘⢢⠀⠀⠀⢸⡀⠀⣸⠃
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡇⢸⠀⢀⡜⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⣄⠀⢸⠇⣶
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢧⠈⠉⡡⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠓⠊⠀⣿
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⠚⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⡵⠦⠤⠃
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠶⢤⣄⣀⣀⣀⣀⣀⡤⠴⠚⠁


operation test(): Result[] {
    use qs = Qubit[3];
    //ApplyToEach(H, qs);
    // 4 * 2 = 8 % 7 + 1
    X(qs[2]);
    MultiplyConstantModulo(2, 7, qs);
    return MResetEachZ(qs);
}

operation TestBasicMultiplication(): Result[] {
    use qs = Qubit[3];
    // Test: 3 * 5 = 15 % 7 = 1
    X(qs[0]); // |001⟩ = 1
    X(qs[1]); // |011⟩ = 3
    MultiplyConstantModulo(5, 7, qs);
    return MResetEachZ(qs);
}

operation TestZeroInput(): Result[] {
    use qs = Qubit[3];
    // Test: 0 * c = 0 pour tout c
    // |000⟩ reste |000⟩
    MultiplyConstantModulo(3, 7, qs);
    return MResetEachZ(qs);
}

operation TestMultiplyByOne(): Result[] {
    use qs = Qubit[3];
    // Test: 5 * 1 = 5 % 7 = 5
    X(qs[0]); // |001⟩
    X(qs[2]); // |101⟩ = 5
    MultiplyConstantModulo(1, 7, qs);
    return MResetEachZ(qs);
}

operation Test5QubitBasic1(): Result[] {
    use qs = Qubit[5];
    // Test: 15 * 3 = 45 % 31 = 14
    // 15 = |01111⟩
    X(qs[0]); X(qs[1]); X(qs[2]); X(qs[3]); // |01111⟩ = 15
    MultiplyConstantModulo(3, 31, qs);
    return MResetEachZ(qs);
}

operation TestAddCycle() : Unit {
    // Doit faire un cycle complet : N additions de 1 mod N → identité
    use qs = Qubit[3];
    X(qs[2]);                          // qs = 1
    AddConstantModulo(5, 7, qs);
    DumpMachine();
    ResetAll(qs);
}

operation TestMulFermat() : Unit {
    // Petit Fermat : g^(p-1) = 1 mod p pour p premier et g coprime
    // Pour p=7, g=3 : 3^6 mod 7 = 729 mod 7 = 1. On vérifie en appliquant *3 six fois.
    use qs = Qubit[3];
    X(qs[0]);                          // qs = 1
    for _ in 1..6 {
        MultiplyConstantModulo(3, 7, qs);
    }
    DumpMachine();                     // attendu : qs = |100> = 1 (Fermat OK)
    ResetAll(qs);
}