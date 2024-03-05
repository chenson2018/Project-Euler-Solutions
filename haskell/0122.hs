-- problem here: https://projecteuler.net/problem=122

{-
`paths n` is a list of lists, where each list is a possible path of exponentiation

I keep the lists in order so that the greatest exponent is the head

the thought process is
   - given the list of exponents we have already, consider all combinations with itself and the greatest exponent (valid for n < 12509)
   - filter out duplicates (e.g. 1 + n = 2 + n - 1 = 3 + n - 2 = ...)
   - append this new exponent
-}

-- See https://aplwiki.com/wiki/Train
fork :: (a -> b -> c) -> (d -> a) -> (d -> b) -> d -> c
fork combine f g d = combine (f d) (g d)

paths :: Int -> [[Int]]
paths 0 = [[1]]
paths n = concatMap (fork map (flip (:)) nextMul) prev
  where
    prev = paths (n - 1)
    nextMul xs = (+) <$> xs <*> [head xs]

-- this is cool, a practical use of the applicative style
-- note how this allows us to "fail" for a finite list without enough depth
minPath :: [[[Int]]] -> Int -> Maybe Int
minPath [] _ = Nothing
minPath (x : xs) n
  | any (elem n) x = Just 0
  | otherwise = (+) <$> Just 1 <*> minPath xs n

main :: IO ()
main = do
  let mems = map paths [0 ..]
  let mins = map (minPath mems) [1 .. 200]
  let ans = (fmap sum . sequence) mins
  print ans
