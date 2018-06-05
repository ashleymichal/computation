flip :: (a -> (b -> c)) -> (b -> (a -> c))

id :: (z -> z)

z -> z === (a -> (b -> c))

z === a
z === (b -> c)

a === (b -> c)

flip id :: b -> a -> c
-- as above a === (b -> c)
flip id :: b -> (b -> c) -> c

lolApply :: b -> (b -> c) -> c
lolApply aB bToC = bToC aB


-- apply id to zipWith
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
id :: (z -> z)

-- again, (a -> b -> c) ~= (a -> (b -> c))
z === a
z === (b -> c)
-- so again
a === (b -> c)

zipWith id :: [b -> c] -> [b] -> [c]

weird' :: [b -> c] -> [b] -> [c]
weird' listOfFns listOfBs = undefined
-- zippy-apply

-- apply id to "bind" operator
-- >>=

flip (>>=) :: (a -> [b]) -> [a] -> [b]
id :: z -> z

a === [b]

flip (>>=) id :: [a] -> a
flip (>>=) id :: [[b]] -> [b]
lolFlatten someList = undefined

