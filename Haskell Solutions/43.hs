#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

import Data.List

--get groups of n and check if all are divisible by primes
splitPan :: String -> Int -> Bool
splitPan x n = all (==0) remain
    where remain = zipWith (\x y -> x `mod` y) splits [2, 3, 5, 7, 11, 13, 17]
          splits = map (read) (drop 1 (gather n x))

gather :: Int -> [a] -> [[a]]          
gather n = map (take n) . dropLast n . tails
    where dropLast n xs = zipWith const xs (drop n xs)


main = do
    --get permuations of ten digit numbers without repeats
    let combo = (map) (concat) ((map.map) (show) (permutations [0..9]))
    
    let pan = filter (\x -> splitPan x 3) combo
    let ans = sum (map (read) pan)
    
    print(ans)