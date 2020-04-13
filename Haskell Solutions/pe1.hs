#!/usr/bin/env stack
-- stack --resolver lts-13.7 script

main = do
    let list = [1..999]
    let filt = filter(\x -> mod x 3 == 0 || mod x 5 == 0) list
    print (sum filt)