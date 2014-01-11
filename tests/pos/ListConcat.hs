{--! run liquid with no-termination -}

module Foo () where
import Data.Set (Set(..)) 
import Prelude hiding (concat)

{-@ measure llElts :: [[a]] -> (Set a) 
    llElts([])   = {v | (? Set_emp(v))}
    llElts(x:xs) = {v | v = (Set_cup (listElts x) (llElts xs)) }

  @-}


{-@ concat :: ys:[[a]] -> {v:[a]|listElts(v) = llElts(ys)} @-}
concat :: [[a]] ->  [a]
concat  []         = []
concat ([]: xs)    = concat xs
concat ((y:ys):xs) = y : concat (ys:xs)






