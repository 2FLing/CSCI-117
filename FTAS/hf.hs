data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

append ys Nil = ys
append (Snoc a b) (Snoc c d) = Snoc (append (Snoc a b) c) d -- Take one element out from (Snoc c d) and add it to the back
                                    --apply that to the rest of element 
len xs = helper xs 0 where
    helper [] a = a
    helper (x:xs) a = helper xs (a+1)

add x y f = f(x) + f(y)