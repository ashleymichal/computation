# Run tests with:  nix eval -f ./mathy.nix test


with builtins;

let

    fix = f: f (fix f);

    addy-rigid = rec {
        op = x: y: x + y;
        mult = x: y: if (y == 1) then x else op x (mult x (y - 1));
    };

    addy-fix = fix (self: {
        op = x: y: x + y;
        mult = x: y: if (y == 1) then x else self.op x (self.mult x (y - 1));
    });

    addy-mixin = self: {
        op = x: y: x + y;
        mult = x: y: if (y == 1) then x else self.op x (self.mult x (y - 1));
    };

    multy-mixin = self: {
        op = x: y: x * y;
    };

    multy-fail = addy-rigid // { op = x: y: x * y; };

    multy-fix  = fix (self: addy-mixin self // multy-mixin self);

    test = (import ./test.nix).assertAllTrue ({assertTrue, ...}: [
        (assertTrue "addy-rigid"  (with addy-rigid; mult (op 2 3) 4 == 20))
        (assertTrue "addy-fix"    (with addy-fix;   mult (op 2 3) 4 == 20))
        (assertTrue "multy-fail"  (with multy-fail; mult (op 2 3) 4 != 1296))
        (assertTrue "multy-fail"  (with multy-fail; mult (op 2 3) 4 == 24))
        (assertTrue "multy-fix"   (with multy-fix;  mult (op 2 3) 4 == 1296))
    ]);

in { inherit test; }

