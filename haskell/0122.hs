-- problem here: https://projecteuler.net/problem=122

-- apply a function to the Cartesian product of two lists
cartWith :: (a -> b -> c) -> [a] -> [b] -> [c]
cartWith f xs ys = [f x y | x <- xs, y <- ys]

{-
`path n` is a list of lists, where each list is a possible path of exponentiation

I keep the lists in order so that the greatest exponent is the head

the thought process is
   - given the list of exponents we have already, consider all combinations with itself and the greatest exponent (valid for n < 12509)
   - filter out any results smaller than the largest exponent
   - filter out duplicates (e.g. 1 + n = 2 + n - 1 = 3 + n - 2 = ...)
   - append this new exponent
-}
path :: Int -> [[Int]]
path 0 = [[1]]
path n = concatMap (\xs -> map (: xs) $ nextMul xs) prev
  where
    prev = path (n - 1)
    nextMul xs = cartWith (+) xs [head xs]

-- this is cool, a practical use of the applicative style
minPath :: [[Int]] -> Int -> Maybe Int
minPath [] _ = Nothing
minPath (x : xs) n
  | n `elem` x = Just 0
  | otherwise = (+) <$> Just 1 <*> minPath xs n

main :: IO ()
main = do
  let mems = map (concat . path) [0 ..]
  let mins = map (minPath mems) [1 .. 200]
  let ans = (fmap sum . sequence) mins
  print ans
