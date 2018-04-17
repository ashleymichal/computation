zipWith :: (a -> b -> c) -> ([a] -> [b] -> [c])
id :: x -> x
-- remember that (a -> b -> c) => (a -> (b -> c))

zipWith id :: ([a] -> ([b] -> [c])) 
-- such that x -> x = a -> (b -> c)

-- if x == a && x == (b -> c) then a == b -> c
zipWith id :: [b -> c] -> [b] -> [c]

-- for concatMap id
(a -> [b]) -> [a] -> [b]

-- if a == [b]
[a] -> [b]
[[b]] -> [b]

