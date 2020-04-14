#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

import Data.List
import Control.Monad (replicateM)
import Data.Sort

combinations :: Int -> [a] -> [[a]]
combinations k ns = filter ((k==).length) $ subsequences ns

--add the flipped 6/9 
extended :: [Int] -> [Int]
extended xs
    | elem 6 xs = nub $ xs ++ [9]
    | elem 9 xs = nub $ xs ++ [6] 
    | otherwise = xs

--function to see if a pair of dice can make a certain number
can_make :: [[Int]] -> [Int] -> Bool
can_make pair square = elem (square !! 0) (pair !! 0) && elem (square !! 1) (pair !! 1) || 
                       elem (square !! 1) (pair !! 0) && elem (square !! 0) (pair !! 1)

--check to see if dice pair can make each square 1^2 .. 9^2
square_pair :: [[Int]] -> Bool
square_pair pair = can_make pair [0, 1] &&
                   can_make pair [0, 4] &&
                   can_make pair [0, 9] &&
                   can_make pair [1, 6] &&
                   can_make pair [2, 5] &&
                   can_make pair [3, 6] &&
                   can_make pair [4, 9] &&
                   can_make pair [6, 4] &&
                   can_make pair [8, 1]

main = do
    -- get the possible dice
    -- there are 210 = 10 choose 6 
    let distict = combinations 6 [0..9]
    
    --get each possible pairs from the above
    --note that we eliminate duplicates so that
    --there are (210^2 + 10 choose 6)/2 unique pairs
    --this elimination could be implemented much more efficiently
    let pairs   = nub (map (sort) $ replicateM 2 distict)
    
    --map extended to include flipped 6/9
    let extended_pairs = (map.map) extended pairs
    
    --count how many pairs can make each square
    let ans = length (filter (==True) $ map (square_pair) extended_pairs)
    
    print ans
