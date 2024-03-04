iterBlue :: (Int, Int) -> (Int, Int)
iterBlue (x, y) = (x, 1 + 2 * x - y)

iterRed :: (Int, Int) -> (Int, Int)
iterRed (x, y) = (1 - x - 2 * y, y)

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
