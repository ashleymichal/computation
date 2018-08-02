# Run tests with:  nix eval -f ./fix.nix test

# This file illustrates a few ways to write the fixed-point function `fix`.
#
# Fixed-point function are intrinsically recursive, so we need some
# language-level support to define them.  Nix has two language constructs that
# are recursive:
#
#    1) let bindings 
#
#    2) attribute sets annotated with the "rec" keyword.
#
# So we have a few ways we can play around with defining `fix` in Nix.

let

    fix-let-outer   =              f: f (fix-let-outer f);
    fix-let-inner   =              f: let x = f x; in x;
    fix-attr-nonrec = (    { fix = f: let x = f x; in x; }).fix;
    fix-attr-rec    = (rec { fix = f: f (fix f);         }).fix;

    fac             =         n: if n == 1 then 1 else fac (n - 1) * n;

    fac-let-outer   = 
        fix-let-outer   (fac: n: if n == 1 then 1 else fac (n - 1) * n);

    fac-let-inner   = 
        fix-let-inner   (fac: n: if n == 1 then 1 else fac (n - 1) * n);

    fac-attr-nonrec =
        fix-attr-nonrec (fac: n: if n == 1 then 1 else fac (n - 1) * n);

    fac-attr-rec    = 
        fix-attr-rec    (fac: n: if n == 1 then 1 else fac (n - 1) * n);

    test = (import ./test.nix).assertAllTrue ({assertTrue, ...}: [
        (assertTrue "fac 4 == 24"             (fac 4             == 24))
        (assertTrue "fac-let-outer 4 == 24"   (fac-let-outer 4   == 24))
        (assertTrue "fac-let-inner 4 == 24"   (fac-let-inner 4   == 24))
        (assertTrue "fac-attr-nonrec 4 == 24" (fac-attr-nonrec 4 == 24))
        (assertTrue "fac-attr-rec 4 == 24"    (fac-attr-rec 4    == 24))
    ]);

in { inherit test; }

