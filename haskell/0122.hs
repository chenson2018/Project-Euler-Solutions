-- problem here: https://projecteuler.net/problem=122

{-
`paths n` is a list of lists, where each list is a possible path of exponentiation

I keep the lists in order so that the greatest exponent is the head

the thought process is
   - start with a the list of exponents we have already, with a base case of [[1]]
   - consider all combinations with itself and the greatest exponent (valid for n < 12509)
   - append this new exponent and flatten the possibilities into a single list
-}

-- `map <$> xs <*> ys` is a fork!!
-- See https://aplwiki.com/wiki/Train

paths :: Int -> [[Int]]
paths 0 = [[1]]
paths n = concatMap consNext prev
  where
    prev = paths (n - 1)
    consNext = map <$> flip (:) <*> nextMul
    nextMul xs = (+) <$> xs <*> [head xs]

-- this is cool, a practical use of the applicative style
-- note how this allows us to "fail" for a finite list without enough depth
minPath :: [[[Int]]] -> Int -> Maybe Int
minPath [] _ = Nothing
minPath (x : xs) n
  | any (elem n) x = Just 0
  | otherwise = (+1) <$> minPath xs n

main :: IO ()
main = do
  let mems = map paths [0 ..]
  let mins = map (minPath mems) [1 .. 200]
  let ans = (fmap sum . sequence) mins
  print ans
