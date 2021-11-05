#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

--fibonacci series with limit of 1000 digits

main = do
    let fibs' = 1 : 1 : zipWith (+) fibs' (tail fibs')
    let ndigit = takeWhile (\i -> length(show i) < 1000 ) fibs'
    let lThousand = length(ndigit) + 1
    print(lThousand)