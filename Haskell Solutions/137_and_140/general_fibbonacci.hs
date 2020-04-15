#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

import Math.NumberTheory.Powers.Squares

--takes in g_0 and g_1
--gives the series starting from g_0
gen_fib :: Int -> Int -> [Int]
gen_fib a b = seq where
              seq = a : b : zipWith (+) seq (tail seq)

--takes in g_0 and g_1 and reurns the discriminant function
discriminant_fib :: Int -> Int -> (Int -> Int)
discriminant_fib a b = f where
                       f s = s^2 + 2*s*b + b^2 + 4*s^2 + 4*a*s

main = do
    let discriminant = discriminant_fib 3 1
    
    --let test = take 15 $ filter (\x -> isSquare (discriminant x)) [1..]
    let test = take 30 $ gen_fib 3 1
    print test