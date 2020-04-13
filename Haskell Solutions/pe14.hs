#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

collatz :: Integer -> Integer
collatz x = 
    if x `mod` 2 == 0 then x `div` 2
    else 3*x + 1

main = do
    --collatz sequence for 1 through 1000000
    let sequences = map (iterate collatz) [1..1000000]
    
    --evaluate each sequence until it reaches 1
    let limit = map (takeWhile (>1)) sequences
    let addOne = map (++ [1]) limit
    
    let len = map (length) addOne
    let maxLen = maximum(len)
    
    --find sequence with max length
    let seqFilt = map (take 1) (filter (\l -> length l == maxLen) addOne)
    
    print(seqFilt)