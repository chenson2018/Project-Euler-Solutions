#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

import Data.Matrix
import Data.List
import Data.Ord
import Data.Maybe

--see https://en.wikipedia.org/wiki/Tree_of_primitive_Pythagorean_triples

seed :: Matrix Integer
seed = fromList 3 1 [3, 4, 5]

a :: Matrix Integer
a = fromLists [[ 1, -2, 2],
               [ 2, -1, 2],
               [ 2, -2, 3]]

b :: Matrix Integer
b = fromLists [[ 1, 2, 2],
               [ 2, 1, 2],
               [ 2, 2, 3]]
 
c :: Matrix Integer 
c = fromLists [[-1, 2, 2],
               [-2, 1, 2],
               [-2, 2, 3]]

next_branch :: [Matrix Integer] -> [Matrix Integer]
next_branch triplets = concat $ map (\xs -> [a*xs, b*xs, c*xs]) triplets

--get the largest perimeter for n_layers of the ternary tree
max_perimeter :: Int -> Integer
max_perimeter n_layer =  head $
                         map sum $
                         (sortBy ((flip . comparing) sum))$
                         concat $
                         take n_layer $
                         ((map.map) toList $ iterate next_branch [seed])
         
--check if the triangle admits a tiling
can_tile :: [Integer] -> Bool
can_tile [a, b, c] = c `mod` (b-a) == 0

main = do
    let p_limit = 10^8
        
        --find the first layer that has perimeters exceding 10^8
        layers_needed = fromJust $ 
                        find (\n -> max_perimeter n > p_limit) [1..]
        
        --filer out excess triples
        primitives = filter ((<=p_limit) . sum) $
                     concat $
                     take layers_needed $
                     (map.map) toList $ iterate next_branch [seed]
        
        --filter for triples that can tile
        --divide each perimeter by 10^8 to see how many 
        --tilingseach primitive generates
        primitive_tiles = filter (can_tile) primitives
        ans = sum $ map (\xs -> 10^8 `div` (sum xs)) primitive_tiles
        
    print ans