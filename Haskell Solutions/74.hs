#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

import Data.Set (member)
import qualified Data.Set as Set

--https://stackoverflow.com/a/28759274/11090784
takeUntilDuplicate :: Ord a => [a] -> [a]
takeUntilDuplicate xs = foldr go (const []) xs Set.empty
  where
    go x cont set
      | x `member` set = []
      | otherwise      = x : cont (Set.insert x set)

--get sum of factorial of digits
df_sum :: Int -> Int
df_sum x = sum $ map (factorial) [read [a] :: Int | a <- (show x)]

--naive factorial implementation
--acceptable as we are only using 0! through 9! 
factorial :: Int -> Int
factorial n
    | n < 0     = 0
    | otherwise = product [1..n]

--iterate df_sum until chain repeats
chain :: Int -> [Int]
chain x = takeUntilDuplicate $ iterate (df_sum) x

main = do
    let chain_len = map (length . chain) [1..999999]
    let ans = length $ filter (==60) chain_len
    print ans