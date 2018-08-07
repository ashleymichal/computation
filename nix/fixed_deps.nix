# see the result with:
# nix eval '(builtins.toJSON (import ./fixed_deps.nix).example)' --raw | jq .


rec {

    # emptyPkgs :: PkgSet
    emptyPkgs = {};

    # constructor function
    # type Name = String
    # type Version = String
    # type Id = String
    # type Package = { _id :: Id, deps = [Package] }

    # package :: Name -> Version -> [Package] -> Package
    package = name: version: deps:
        {
            _id = "${name}-${version}";
            inherit deps;
        };

    # type PkgSet = AttrSet<Package>
    # addPackage :: Package -> PkgSet -> PkgSet
    addPackage = p: ps: ps // { "${p.name}" = p; }; # `//` -> attr set merge

    # type PkgsClass = PkgSet -> PkgSet
    topClass = self: emptyPkgs;

    # fix topClass :: Package ~> emptyPkgs
    # fix :: (a -> a) -> a
    fix = f: let x = f x; in x;

    # type Extension = PkgSet -> PkgSet -> PkgSet

    # extend :: PkgsClass -> Extension -> PkgsClass
    extend = class: extn:
        self:
            let super = class self;
            in super // extn self super;

    # constructor for an Extension
    # type ChooseDeps = PkgSet -> PkgSet -> [Package]
    # withPackage :: Name -> Version -> ChooseDeps -> Extension
    withPackage = name: version: chooseDeps:
        self: super: {
            "${name}" = package name version (chooseDeps self super);
        };

    # noDeps :: ChooseDeps
    noDeps = self: super: [];

    # foldl :: (b -> a -> b) -> b -> [a] -> b

    # extendAll :: PkgsClass -> [Extension] -> PkgsClass
    extendAll = builtins.foldl' extend;

    # make :: [Extensions] -> PkgSet
    make = exts: fix (extendAll topClass exts);

    # example :: PkgSet
    example =
        make [
            (withPackage "foo" "1" noDeps)
            (withPackage "bar" "1" (self: super: [self.foo]))
            (withPackage "baz" "1" (self: super: [super.foo]))
            (withPackage "foo" "2" noDeps)
        ];

}
