#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

import Data.Set (member)
import qualified Data.Set as Set
import qualified Data.Map as Map
import Data.Maybe

--get sum of factorial of digits
df_sum :: Int -> Int
df_sum x = sum $ map (factorial_lookup) [read [a] :: Int | a <- (show x)]

--iterate df_sum until chain repeats
chain :: Int -> [Int]
chain x = takeUntilDuplicate $ iterate (df_sum) x

--naive factorial implementation
factorial :: Int -> Int
factorial n
    | n < 0     = 0
    | otherwise = product [1..n]

--lookup table for factoials 0! through 9!
factorial_map = Map.fromList $ zip [0..9] (map (factorial) [0..9]) 

--function to use lookup table
factorial_lookup :: Int -> Int
factorial_lookup x = case Map.lookup x factorial_map of
                        Nothing -> error "A facorital outside lookup range was attempted"
                        Just a  -> a

--function to take from list until duplicate
--https://stackoverflow.com/a/28759274/11090784
takeUntilDuplicate :: Ord a => [a] -> [a]
takeUntilDuplicate xs = foldr go (const []) xs Set.empty
  where
    go x cont set
      | x `member` set = []
      | otherwise      = x : cont (Set.insert x set)

main = do
    let chain_len = map (length . chain) [1..999999]
    let ans = length $ filter (==60) chain_len
    print ans