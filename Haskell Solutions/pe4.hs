#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

import Data.List

reverse_int :: Int -> Int
reverse_int x =  read (reverse (show x)) :: Int

cartProd :: [Int] -> [Int] -> [[Int]]
cartProd xs ys = [[x,y] | x <- xs, y <- ys]

main = do
    let combo = cartProd [100..999] [100..999]
    let mult  = map (product) combo 
    let palindrome = filter (\x -> x == (reverse_int x)) mult
    let ans = maximum palindrome
    print ans