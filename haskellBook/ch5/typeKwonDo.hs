data Woot

data Blah

f :: Woot -> Blah
f = undefined

g :: (Blah, Woot) -> (Blah, Blah)
g (b, w) = (b, f w)

--


f' :: Int -> String
f' = undefined

g' :: String -> Char
g' = undefined

h :: Int -> Char
h a = g' (f' a)

--


data A
data B
data C

q :: A -> B
q = undefined

w :: B -> C
w = undefined

e :: A -> C
e t = w (q t)

--


data X
data Y
data Z

xz :: X -> Z
xz = undefined

yz :: Y -> Z
yz = undefined

xform :: (X, Y) -> (Z, Z)
xform (fst, snd) = (xz fst, yz snd)

--


munge :: (x -> y)
      -> (y -> (w, z))
      -> x
      -> w
munge xToY yToTup anX = fst (yToTup (xToY anX))

