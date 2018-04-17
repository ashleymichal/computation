module List where

data List a = Cons a (List a) | Nil

instance Show a => Show (List a) where
    -- show (Cons h t) = show h ++ ":" ++ show t
    -- show Nil = "[]"
    show = show . toHsList

lMatch :: b -> (a -> List a -> b) -> List a -> b
lMatch ifNil _ifCons Nil        = ifNil
lMatch _ifNil ifCons (Cons h t) = ifCons h t

lMatch' :: b -> (a -> List a -> b) -> List a -> b
lMatch' ifNil ifCons list =
    case list of
        Nil      -> ifNil
        Cons h t -> ifCons h t

lFoldR :: b -> (a -> b -> b) -> List a -> b
lFoldR ifNil _ifCons Nil       = ifNil
lFoldR ifNil ifCons (Cons h t) = ifCons h (lFoldR ifNil ifCons t)

lFoldR' :: b -> (a -> b -> b) -> List a -> b
lFoldR' ifNil ifCons list =
    case list of
        Nil      -> ifNil
        Cons h t -> ifCons h (lFoldR'' ifNil ifCons t)

lFoldR'' :: b -> (a -> b -> b) -> List a -> b
lFoldR'' ifNil ifCons list = lMatch ifNil ifCons' list
    where ifCons' h t = ifCons h (lFoldR' ifNil ifCons t)

lSum :: List Int -> Int
lSum = lFoldR 0 (+)

toHsList :: List a -> [a]
toHsList = lFoldR [] (:)

toList :: [a] -> List a
toList = foldr Cons Nil

