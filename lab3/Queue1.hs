module Queue1 (Queue, mtq, ismt, addq, remq) where

---- Interface ----------------
mtq  :: Queue a                  -- empty queue
ismt :: Queue a -> Bool          -- is the queue empty?
addq :: a -> Queue a -> Queue a  -- add element to front of queue
remq :: Queue a -> (a, Queue a)  -- remove element from back of queue;
                                 --   produces error "Can't remove an element
                                 --   from an empty queue" on empty

---- Implementation -----------

{- In this implementation, a queue is represented as an ordinary list.
The "front" of the queue is at the head of the list, and the "back" of
the queue is at the end of the list.
-}

data Queue a = Queue1 [a]

mtq = Queue1 []

ismt (Queue1 xs) = null xs

addq x (Queue1 xs) = Queue1 (x:xs)


remq (Queue1 xs) = if ismt (Queue1 xs) then error "Can't remove an element from an empty queue"
else (last xs, Queue1 (droplast xs)) where
    droplast [] =[]
    droplast [x]=[]
    droplast xs =init xs

