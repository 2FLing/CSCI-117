module Queue2 (Queue, mtq, ismt, addq, remq) where

---- Interface ----------------
mtq  :: Queue a                  -- empty queue
ismt :: Queue a -> Bool          -- is the queue empty?
addq :: a -> Queue a -> Queue a  -- add element to front of queue
remq :: Queue a -> (a, Queue a)  -- remove element from back of queue;
                                 --   produces error "Can't remove an element
                                 --   from an empty queue" on empty

--- Implementation -----------

{- In this implementation, a queue is represented as a pair of lists.
The "front" of the queue is at the head of the first list, and the
"back" of the queue is at the HEAD of the second list.  When the
second list is empty and we want to remove an element, we REVERSE the
elements in the first list and move them to the back, leaving the
first list empty. We can now process the removal request in the usual way.
-}
drop_fst :: [a] -> [a]
drop_fst [] =[]
drop_fst [x]=[]
drop_fst (x:xs)= xs


data Queue a = Queue2 [a] [a]

mtq = Queue2 [] []

ismt (Queue2 x y) = null x && null y

addq x q = help x q where
    help x (Queue2 front back) = Queue2 (x:front) back 

remq q = help q where
    help (Queue2 xs ys)
        | null xs && null ys= error "Can't remove an element from an empty queue"
        | null ys = (last xs, Queue2 [] (drop_fst $ reverse xs))     
        | otherwise = (head ys, Queue2 xs (drop_fst ys))
        

