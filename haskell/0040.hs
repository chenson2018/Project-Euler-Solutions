#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

--function to get nth decimal of champernowne constant
champernowne :: Int -> String
champernowne n = [last (take n (concat $ map (show) [1..]))]

main = do
    let ans = product (map ((read::String->Int) . champernowne) ( take 7 $ iterate (*10) 1 ))
    print ans