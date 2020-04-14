#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

import Data.List (tails)
import Math.NumberTheory.Primes

gather :: Int -> [a] -> [[a]]
gather n = map (take n) . dropLast n . tails
    where dropLast n xs = zipWith const xs (drop n xs)
    
takeWhileInclusive :: (a -> Bool) -> [a] -> [a]
takeWhileInclusive _ [] = []
takeWhileInclusive p (x:xs) = x : if p x then takeWhileInclusive p xs
                                         else []


main = do
    --filter full list of primes
    let max_prime = 1000000
    let primeFilt = takeWhile (<max_prime) primes
    
    --find how many primes (starting at two) sum to the above limit
    --this cound can be made MUCH better
    let max_sum = takeWhile(<max_prime) (scanl1 (+) primes)
    let len = length max_sum
    
    --function to get groups of n primes
    let check n = gather n primeFilt
    
    -- reverse sequence so that largest appears first
    let sequences = reverse(concat(map (check) [2..len]))
    
    --filter out entries that result in even number
    --this could be extended for the simple divisibility rules
    let filt_seq = filter (\x -> even (length x) || (head x) == 2) sequences
    
    --find the first summation that gives a prime
    let ans  = sum(last(takeWhileInclusive (\x -> not((elem (sum x) primeFilt))) sequences))
    
    
    print(ans)