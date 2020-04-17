#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

import Data.List 
import Data.Maybe

takeWhileInclusive :: (a -> Bool) -> [a] -> [a]
takeWhileInclusive _ [] = []
takeWhileInclusive p (x:xs) = x : if p x then takeWhileInclusive p xs
                                         else []

--https://stackoverflow.com/a/7261896/11090784
merge f x [] = x
merge f [] y = y
merge f (x:xs) (y:ys)
               | f x y     =  x : merge f xs     (y:ys) 
               | otherwise =  y : merge f (x:xs) ys 


mmult :: Num a => [[a]] -> [[a]] -> [[a]] 
mmult a b = [ [ sum $ zipWith (*) ar bc | bc <- (transpose b) ] | ar <- a ]

tpgen_matrix = [[[ 1,-2, 2],[ 2 ,-1, 2],[ 2,-2, 3]],
                [[ 1, 2, 2],[ 2 , 1, 2],[ 2, 2, 3]],
                [[-1, 2, 2],[-2 , 1, 2],[-2, 2, 3]]]

matrixsum  =  sum . map sum
tripletsorter x y =  ( matrixsum  x ) < ( matrixsum y ) -- compare perimeter

triplegen_helper b =  foldl1 
            ( merge tripletsorter ) 
            [ h : triplegen_helper h | x <- tpgen_matrix , let h = mmult x b ]

triplets = map (\[[a],[b],[c]] -> [a, b, c]) $ x : triplegen_helper x  where x = [[3],[4],[5]]

main =  do
    let n = 1000
        primitives = takeWhile ((<=n) . sum) triplets
        multiples n = (map.map) (*n) primitives
        test = filter ((==n) . sum) $ concat $ map (multiples) [1..100]
        
    print test