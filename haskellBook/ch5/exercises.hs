{-# LANGUAGE NoMonomorphismRestriction #-}

module DetermineTheType where


example = 1

bigNum x = (^) 5 $ x
wahoo = bigNum $ 10

x = print
y = print "woohoo!"
z = x "hello world!"

a = (+)
b = 5
c = a 10
d = c 200

e = 12 + f
f = 10000 * e


-- write a type signature

functionH :: [a] -> a
functionH (x:_) = x

functionC :: Ord a => a -> a -> Bool
functionC x y =
    if (x > y) then True else False

functionS :: (a, b) -> b
functionS (x, y) = y


-- given a type, write the function

myFunc :: (x -> y)
       -> (y -> z)
       -> c
       -> (a, x)
       -> (a, z)
myFunc xToY yToZ _ (a, x) = (a, yToZ (xToY x))

i :: a -> a
i = id

h :: a -> b -> a
h x y = x

h'' :: b -> a -> b
h'' x y = x

r :: [a] -> [a]
r = undefined

co :: (b -> c) -> (a -> b) -> a -> c
co bToC aToB a = bToC (aToB a)
