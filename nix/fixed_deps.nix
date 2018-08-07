# see the result with:
# nix eval '(builtins.toJSON (import ./fixed_deps.nix).example)' --raw | jq .


rec {
    
    empty = {};

    package = name: version: deps:
        { 
            _id = "${name}-${version}";
            inherit deps;
        };

    addPackage = p: ps: ps // { "${p.name}" = p; };

    topClass = self: {};

    fix = f: let x = f x; in x;

    extend = class: extn:
        self:
            let super = class self;
            in super // extn self super;

    withPackage = name: version: chooseDeps: 
        self: super: {
            "${name}" = package name version (chooseDeps self super);
        };

    noDeps = self: super: [];

    extendAll = builtins.foldl' extend;

    make = exts: fix (extendAll topClass exts);

    example = 
        make [
            (withPackage "foo" "1" noDeps)
            (withPackage "bar" "1" (self: super: [self.foo]))
            (withPackage "baz" "1" (self: super: [super.foo]))
            (withPackage "foo" "2" noDeps)
        ];

}
