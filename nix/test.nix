rec {

    assertTrue = msg: b: 
        let pass-msg = "passed: " + msg;
            fail-msg = "failed: " + msg;
        in if b then builtins.trace pass-msg b else abort fail-msg;

    assertAllTrue = tests: builtins.all (a: a) (tests { inherit assertTrue; });

}
