-- CSci 117, Lab 3:  ADTs and Type Classes

import Data.List (sort)
import Queue1
--import Queue2
import Fraction

---------------- Part 1: Queue client

-- add a list of elements, in order, into a queue
adds :: [a] -> Queue a -> Queue a
adds xs q = help xs q where
    help [] q=q
    help (x:xs) q= addq x (help xs q)

-- remove all elements of the queue, putting them, in order, into a list
rems :: Queue a -> [a]
rems q = help q [] where
    help q l= if ismt q then l else
         help (snd(remq q)) (fst(remq q):l) 

-- test whether adding a given list of elements to an initially empty queue
-- and then removing them all produces the same list (FIFO). Should return True.
testq :: Eq a => [a] -> Bool
testq xs = xs == rems (adds xs mtq)


---------------- Part 2: Using typeclass instances for fractions

-- Construct a fraction, producing an error if it fails
fraction :: Integer -> Integer -> Fraction
fraction a b = case frac a b of
             Nothing -> error "Illegal fraction"
             Just fr -> fr


-- Calculate the average of a list of fractions
-- Give the error "Empty average" if xs is empty
average :: [Fraction] -> Fraction
average xs = undefined

-- Some lists of fractions

list1 = [fraction n (n+1) | n <- [1..20]]
list2 = [fraction 1 n | n <- [1..20]]
--list3 = zipWith (+) list1 list2

-- Make up several more lists for testing


-- Show examples testing the functions sort, sum, product, maximum, minimum,
-- and average on a few lists of fractions each. Think about how these library
-- functions can operate on Fractions, even though they were written long ago
