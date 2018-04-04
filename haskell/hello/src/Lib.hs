module Lib where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

add :: Int -> Int -> Int
add = \x -> \y -> x + y

add' :: Int -> Int -> Int
add' a b = a + b

add'' :: Int -> Int -> Int
add'' x = \y -> x + y -- lol

wat :: Int -> Int -> Int
wat = \x y -> x + y

