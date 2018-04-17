module Tuples where

tupFunc :: (Int, [a])
        -> (Int, [a])
        -> (Int, [a])
tupFunc (a, b) (c, d) = ((a + c), (b ++ d))
