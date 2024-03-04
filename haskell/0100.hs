-- question here: https://projecteuler.net/problem=100

iterBlue :: (Int, Int) -> (Int, Int)
iterBlue (r, b) = (r, 1 + 2 * r - b)

iterRed :: (Int, Int) -> (Int, Int)
iterRed (r, b) = (1 - r - 2 * b, b)

spiral :: (Int, Int) -> Int -> (Int, Int)
spiral init 0 = init
spiral init n = iter $ spiral init (n - 1)
  where
    iter
      | odd n = iterBlue
      | even n = iterRed

merge :: [a] -> [a] -> [a]
merge [] ys = ys
merge (x : xs) ys = x : merge ys xs

main :: IO ()
main = do
  let xs = map (spiral (0, 0)) [0 ..]
  let ys = map (spiral (1, 0)) [0 ..]
  let spiral = merge xs ys
  let positive_spiral = filter (all (> 0)) spiral
  let ans = snd $ head $ filter ((> 10 ^ 12) . uncurry (+)) positive_spiral
  print ans
