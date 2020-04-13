#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

main = do
    let fibs' = 1 : 2 : zipWith (+) fibs' (tail fibs')
    let filt = takeWhile(\x -> (x <= 4000000)) fibs'
    let eve  = filter even filt
    print(sum(eve))