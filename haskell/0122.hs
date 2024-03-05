-- problem here: https://projecteuler.net/problem=122

-- apply a function to the Cartesian product of two lists
cartWith :: (a -> b -> c) -> [a] -> [b] -> [c]
cartWith f xs ys = [f x y | x <- xs, y <- ys]

-- remove duplicates from a list
-- not sure what is most efficient, got this from SO
uniq :: (Eq a) => [a] -> [a]
uniq [] = []
uniq (x : xs) = x : uniq (filter (/= x) xs)

{-
See https://wiki.haskell.org/Memoization

`memoPath n` is a list of lists, where each list is a possible path of exponentiation

I keep the lists in order so that the maximum element (greatest exponent) is the head

the thought process is
   - given the list of exponents we have already, consider all combinations with itself for our next multiplication
   - filter out any results smaller than the largest exponent
   - filter out duplicates (e.g. 1 + n = 2 + n - 1 = 3 + n - 2 = ...)
   - append this new exponent
-}
memoPath :: Int -> [[Int]]
memoPath = (map path [0 ..] !!)
  where
    path 0 = [[1]]
    path n = concatMap (\xs -> map (: xs) $ uniq $ filter (> head xs) (nextMul xs)) prev
      where
        prev = path (n - 1)
        nextMul xs = cartWith (+) xs xs

-- this is cool, a practical use of the applicative style
minPath :: [[Int]] -> Int -> Maybe Int
minPath [] _ = Nothing
minPath (x : xs) n
  | n `elem` x = Just 0
  | otherwise = (+) <$> Just 1 <*> minPath xs n

main :: IO ()
main = do
  let mems = map (concat . memoPath) [0 ..]
  let mins = map (minPath mems) [1 .. 200]
  let ans = (fmap sum . sequence) mins
  print ans
