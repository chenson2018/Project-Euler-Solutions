#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

import Data.Matrix
import Data.List
import Data.Ord

--see https://en.wikipedia.org/wiki/Tree_of_primitive_Pythagorean_triples

seed :: Matrix Int
seed = fromList 3 1 [3, 4, 5]

a :: Matrix Int
a = fromLists [[ 1, -2, 2],
               [ 2, -1, 2],
               [ 2, -2, 3]]

b :: Matrix Int
b = fromLists [[ 1, 2, 2],
               [ 2, 1, 2],
               [ 2, 2, 3]]
 
c :: Matrix Int 
c = fromLists [[-1, 2, 2],
               [-2, 1, 2],
               [-2, 2, 3]]

next_branch :: [Matrix Int] -> [Matrix Int]
next_branch triplets = concat $ map (\xs -> [a*xs, b*xs, c*xs]) triplets



main = do
    let n = 1000
        
        --the tree grows quickly, so I just take the first five layers
        primitives = filter ( (<n) . sum) $
                     concat $
                     take 5 $
                     ((map.map) toList $ iterate next_branch [seed])
                     
        --helper function to get non-primitive multiples
        multiples n = (map.map) (*n) primitives
        
        --the smallest triple is (3, 4, 5) with sum 12
        --this means checking up to multiples of 84 will be sufficient
        ans = filter ((==n) . sum) $ concat $ map (multiples) [1..84]        
    
    print ans
