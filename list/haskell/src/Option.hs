module Option where


data Option a = None | Some a deriving Show

option :: b -> (a -> b) -> Option a -> b
option ifNone _ifSome None     = ifNone
option _ifNone ifSome (Some a) = ifSome a

option' :: b -> (a -> b) -> Option a -> b
option' ifNone ifSome opt =
    case opt of
        None   -> ifNone
        Some a -> ifSome a

oMap :: (a -> b) -> Option a -> Option b
oMap _f None    = None
oMap f (Some a) = Some (f a)

oMap' :: (a -> b) -> Option a -> Option b
oMap' f opt =
    case opt of
        None   -> None
        Some a -> Some (f a)

oMap'' :: (a -> b) -> Option a -> Option b
oMap'' f = option None (Some . f)

