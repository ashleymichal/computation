module List where

data List a = Cons a (List a) | Nil

instance Show a => Show (List a) where
    show (Cons h t) = show h ++ ":" ++ show t
    show Nil = "[]"

lFoldR :: b -> (a -> b -> b) -> List a -> b
lFoldR ifNil _ifCons Nil = ifNil
lFoldR ifNil ifCons (Cons h t) = ifCons h (lFoldR ifNil ifCons t)

lSum :: List Int -> Int
lSum = lFoldR 0 (+)

