#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

import Data.List
import Data.Sort

--check for palidrome
palindrome :: Int -> Bool
palindrome x = reverse_int x == x

--reverse an integer
reverse_int :: Int -> Int
reverse_int x =  read (reverse (show x)) :: Int

--formula for 1^2 + ... + k^2
square_sum :: Int -> Int
square_sum k = (k*(k+1)*(2*k+1)) `div` 6

--formula for start^2 + ... + end^2
con_sum :: Int -> Int -> Int
con_sum start end = (square_sum end) - (square_sum (start-1))

--get all sums from start to start + win
--i.e. start^2 + ... + (start+win)^2
sum_window :: Int -> [Int]
sum_window win  = map (\start -> con_sum start (start+win)) [1..]

main = do
    let n = 10^8
        ans = sum $ 
              nub $ 
              filter (palindrome) $ 
              concat $ 
              takeWhile((>0) . length) $ 
              map (takeWhile(<n) . sum_window) [1..]
    
    print ans
