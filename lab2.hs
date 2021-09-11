-- CSci 117, Lab 2:  Functional techniques, iterators/accumulators,
-- and higher-order functions. Make sure you test all of your functions,
-- including key tests and their output in comments after your code.


---- Part 1: Basic structural recursion ----------------

-- 1. Merge sort

-- Deal a list into two (almost) equal-sizes lists by alternating elements
-- For example, deal [1,2,3,4,5,6,7] = ([1,3,5,7], [2,4,6])
-- and          deal   [2,3,4,5,6,7] = ([2,4,6], [3,5,7])
-- Hint: notice what's happening between the answers to deal [2..7] and
-- deal (1:[2..7]) above to get an idea of how to approach the recursion
deal :: [a] -> ([a],[a])
deal [] = ([],[])
deal (x:xs) = let (ys,zs) = deal xs
              in (x:zs,ys)

-- *Main> deal [1,3,4,5,9]
-- ([1,4,9],[3,5])

-- *Main> deal [2,3,4,5,6,7]
-- ([2,4,6],[3,5,7])

-- Now implement merge and mergesort (ms), and test with some
-- scrambled lists to gain confidence that your code is correct
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y = x : merge xs (y:ys)
  | x > y  = y : merge (x:xs) ys

-- *Main> merge [1,2,3,4] [5,6,7]
-- [1,2,3,4,5,6,7]

-- *Main> merge [1,5,3,9] [2,4,6,8]
-- [1,2,4,5,3,6,8,9]

ms :: Ord a => [a] -> [a]                                                                     
ms [] = []
ms [x] = [x]
ms xs = merge (ms$fst$deal xs) (ms$snd$deal xs)   -- general case: deal, recursive call, merge
-- *Main> ms [1,5,3,6,8,5,3]
-- [1,3,3,5,5,6,8]

-- *Main> ms [6,4,7,3,9,1,4]
-- [1,3,4,4,6,7,9]

-- 2. A backward list data structure 

-- Back Lists: Lists where elements are added to the back ("snoc" == rev "cons")
-- For example, the list [1,2,3] is represented as Snoc (Snoc (Snoc Nil 1) 2) 3
data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

-- Add an element to the beginning of a BList, like (:) does
cons :: a -> BList a -> BList a
cons x Nil= Snoc Nil x
cons x (Snoc y z) = Snoc (cons x y) z

-- *Main> cons 0 (Snoc (Snoc (Snoc Nil 1) 2) 3)
--Snoc (Snoc (Snoc (Snoc Nil 0) 1) 2) 3
-- *Main> cons 7 (Snoc (Snoc (Snoc Nil 1) 6) 4)
--Snoc (Snoc (Snoc (Snoc Nil 7) 1) 6) 4

-- Convert a usual list into a BList (hint: use cons in the recursive case)
toBList :: [a] -> BList a
toBList [] = Nil
toBList (x:xs) = cons x (toBList xs) 

-- *Main> toBList [1,2,6,4,3]
-- Snoc (Snoc (Snoc (Snoc (Snoc Nil 1) 2) 6) 4) 3
-- *Main> toBList [6,4,2,1,7]
-- Snoc (Snoc (Snoc (Snoc (Snoc Nil 6) 4) 2) 1) 7

-- Add an element to the end of an ordinary list
snoc :: [a] -> a -> [a]
snoc x a  = x++[a]

-- *Main> snoc [5,4,1,6] 3
-- [5,4,1,6,3]

-- Convert a BList into an ordinary list (hint: use snoc in the recursive case)
fromBList :: BList a -> [a]
fromBList Nil = []
fromBList (Snoc Nil a) =[a]
fromBList (Snoc b a)= snoc (fromBList b) a 

-- *Main> fromBList (Snoc (Snoc (Snoc (Snoc Nil 7) 1) 6) 4)
-- [7,1,6,4]

-- *Main> fromBList (Snoc (Snoc (Snoc (Snoc (Snoc Nil 1) 2) 6) 4) 3)
-- [1,2,6,4,3]


-- 3. A binary tree data structure
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)

-- Count number of Empty's in the tree
num_empties :: Tree a -> Int
num_empties Empty = 1
num_empties (Node a b c) = num_empties b+num_empties c

-- *Main> num_empties (Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty))
-- 4

-- Count number of Node's in the tree
num_nodes :: Tree a -> Int
num_nodes Empty = 0
num_nodes (Node a b c) =num_nodes b + num_nodes c + 1 

-- *Main> num_nodes (Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty))
-- 3

-- Insert a new node in the leftmost spot in the tree
insert_left :: a -> Tree a -> Tree a
insert_left a Empty= Node a Empty Empty
insert_left a (Node b c d) =  Node b (insert_left a c) d

-- *Main> insert_left 4  (Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty))                      
-- Node 1 (Node 2 (Node 4 Empty Empty) Empty) (Node 3 Empty Empty)

-- Insert a new node in the rightmost spot in the tree
insert_right :: a -> Tree a -> Tree a
insert_right a Empty= Node a Empty Empty
insert_right a (Node b c d)= Node b c (insert_right a d) 

-- *Main> insert_right 6  (Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty))
-- Node 1 (Node 2 Empty Empty) (Node 3 Empty (Node 6 Empty Empty))

-- Add up all the node values in a tree of numbers
sum_nodes :: Num a => Tree a -> a
sum_nodes Empty =0
sum_nodes (Node a b c)= a+sum_nodes b+sum_nodes c  

-- *Main> sum_nodes (Node 1 (Node 2 Empty Empty) (Node 3 Empty (Node 6 Empty Empty)))
-- 12

-- Produce a list of the node values in the tree via an inorder traversal
-- Feel free to use concatenation (++)
inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node a Empty Empty) = [a]
inorder (Node a b c) = inorder b++[a]++inorder c   

-- *Main> inorder (Node 1 (Node 2 Empty Empty) (Node 3 Empty (Node 6 Empty Empty)))
-- [2,1,3,6]

-- *Main> inorder (Node 1 (Node 2 (Node 3 (Empty) (Empty)) (Node 4 (Empty) (Empty))) (Node 5 (Node 6 (Empty) (Empty)) (Node 7 (Empty) (Empty)))) 
-- [3,2,4,1,6,5,7]

-- 4. A different, leaf-based tree data structure
data Tree2 a = Leaf a | Node2 a (Tree2 a) (Tree2 a) deriving Show

-- Count the number of elements in the tree (leaf or node)
num_elts :: Tree2 a -> Int
num_elts (Leaf a) = 1
num_elts (Node2 a b c)= num_elts b+ num_elts c+1 

-- num_elts (Node2 1 (Node2 2 (Leaf 3)(Leaf 4))(Node2 5 (Leaf 6) (Leaf 7)))
-- 7

-- Add up all the elements in a tree of numbers
sum_nodes2 :: Num a => Tree2 a -> a
sum_nodes2 (Leaf a) = a 
sum_nodes2 (Node2 a b c)= a+sum_nodes2 b + sum_nodes2 c 

-- sum_nodes2 (Node2 1 (Node2 2 (Leaf 3)(Leaf 4))(Node2 5 (Leaf 6) (Leaf 7)))
-- 28

-- Produce a list of the elements in the tree via an inorder traversal
-- Again, feel free to use concatenation (++)
inorder2 :: Tree2 a -> [a]
inorder2 (Leaf a)=[a]
inorder2 (Node2 a b c)=inorder2 b++[a]++inorder2 c 

-- inorder2 (Node2 1 (Node2 2 (Leaf 3)(Leaf 4))(Node2 5 (Leaf 6) (Leaf 7)))           
-- [3,2,4,1,6,5,7]

-- Convert a Tree2 into an equivalent Tree1 (with the same elements)
conv21 :: Tree2 a -> Tree a
conv21 (Leaf a) = Node a Empty Empty
conv21 (Node2 a b c)= Node a (conv21 b) (conv21 c)  

-- conv21 (Node2 1 (Node2 2 (Leaf 3)(Leaf 4))(Node2 5 (Leaf 6) (Leaf 7))) 
-- Node 1 (Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)) (Node 5 (Node 6 Empty Empty) (Node 7 Empty Empty))

---- Part 2: Iteration and Accumulators ----------------
--data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

-- Both toBList and fromBList from Part 1 Problem 2 are O(n^2) operations.
-- Reimplement them using iterative helper functions (locally defined using
-- a 'where' clause) with accumulators to make them O(n)
toBList' :: [a] -> BList a
toBList' l= ltob l Nil where
  ltob [] a = a
  ltob [x] a= Snoc a x
  ltob xs a = Snoc (ltob (init xs) a) (last xs)

-- toBList' [3,2,4,1,6,5,7]
-- Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc Nil 3) 2) 4) 1) 6) 5) 7


fromBList' :: BList a -> [a]
fromBList' bl = btol bl [] where
  btol Nil l =l
  btol (Snoc a b) l=btol a l++[b]

--fromBList' (Snoc (Snoc (Snoc (Snoc (Snoc Nil 1) 2) 6) 4) 3)
-- [1,2,6,4,3]

-- Even tree functions that do multiple recursive calls can be rewritten
-- iteratively using lists of trees and an accumulator. For example,
sum_nodes' :: Num a => Tree a -> a
sum_nodes' t = sum_nodes_it [t] 0 where
  sum_nodes_it :: Num a => [Tree a] -> a -> a
  sum_nodes_it [] a = a
  sum_nodes_it (Empty:ts) a = sum_nodes_it ts a
  sum_nodes_it (Node n t1 t2:ts) a = sum_nodes_it (t1:t2:ts) (n+a)

-- sum_nodes' (Node 1 (Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)) (Node 5 (Node 6 Empty Empty) (Node 7 Empty Empty)))
-- 28

-- Use the same technique to convert num_empties, num_nodes, and sum_nodes2
-- into iterative functions with accumulators

num_empties' :: Tree a -> Int
num_empties' t = nmties [t] 0 where
  nmties [] a=a
  nmties (Empty:ts) a= nmties ts (a+1)
  nmties (Node n t1 t2:ts) a=nmties (t1:t2:ts) a

-- num_empties' (Node 1 (Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)) (Node 5 (Node 6 Empty Empty) (Node 7 Empty Empty)))           
-- 8

num_nodes' :: Tree a -> Int
num_nodes' t = nmnoes [t] 0 where
  nmnoes [] a =a
  nmnoes (Empty:ts) a=nmnoes ts a
  nmnoes (Node n t1 t2:ts) a = nmnoes (t1:t2:ts) (a+1)

-- num_nodes' (Node 1 (Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)) (Node 5 (Node 6 Empty Empty) (Node 7 Empty Empty))) 
-- 7

sum_nodes2' :: Num a => Tree2 a -> a
sum_nodes2' tr2 = sumnodes [tr2] 0 where
  sumnodes [] a = a
  sumnodes (Leaf x:ts) a= sumnodes ts (x+a)
  sumnodes (Node2 n t1 t2:ts) a= sumnodes (t1:t2:ts) (n+a)

-- sum_nodes2' (Node2 1 (Node2 2 (Leaf 3)(Leaf 4))(Node2 5 (Leaf 6) (Leaf 7)))
-- 28

-- Use the technique once more to rewrite inorder2 so it avoids doing any
-- concatenations, using only (:).
-- Hint 1: (:) produces lists from back to front, so you should do the same.
-- Hint 2: You may need to get creative with your lists of trees to get the
-- right output.
inorder2' :: Tree2 a -> [a]
inorder2' t =inord [t] [] where
  inord [] l=l
  inord ((Leaf a):ts) l=inord ts (a:l)
  inord((Node2 n t1 t2):ts) l = inord(t2:Leaf n:t1:ts) l

-- inorder2' (Node2 1 (Node2 2 (Leaf 3)(Leaf 4))(Node2 5 (Leaf 6) (Leaf 7)))                   
-- [3,2,4,1,6,5,7]

---- Part 3: Higher-order functions ----------------

-- The functions map, all, any, filter, dropWhile, takeWhile, and break
-- from the Prelude are all higher-order functions. Reimplement them here
-- as list recursions. break should process each element of the list at
-- most once. All functions should produce the same output as the originals.

my_map :: (a -> b) -> [a] -> [b]
my_map fn [] =[]
my_map fn (x:xs) = (fn x): (my_map fn xs)

-- my_map (+1) [1,4,5,3,2]
-- [2,5,6,4,3]

my_all :: (a -> Bool) -> [a] -> Bool
my_all bl [] = True
my_all bl (x:xs)= bl x && (my_all bl xs)

--my_all (<10) [1,3,5,7,9]
-- True
-- my_all (<10) [1,3,5,7,11]
-- False

my_any :: (a -> Bool) -> [a] -> Bool
my_any bl [] = False
my_any bl (x:xs) = bl x || (my_any bl xs) 

-- my_any (<10) [1,3,5,7,11]
-- True
-- my_any (<10) [11,13,15,12,11]
--False

my_filter :: (a -> Bool) -> [a] -> [a]
my_filter bl []=[]
my_filter bl (x:xs)= if bl x then x:(my_filter bl xs)
else my_filter bl xs 

--  my_filter (>5) [1,2,3,4,5,6,7,8]
-- [6,7,8]
-- my_filter odd [3,6,7,9,12,14]
-- [3,7,9]

my_dropWhile :: (a -> Bool) -> [a] -> [a]
my_dropWhile bl []= []
my_dropWhile bl (x:xs)=if bl x then my_dropWhile bl xs
else (x:xs)

--  my_dropWhile (<3) [1,2,3,4,5]
-- [3,4,5]
-- my_dropWhile even [2,4,6,7,9,11,12,13,14]
-- [7,9,11,12,13,14]

my_takeWhile :: (a -> Bool) -> [a] -> [a]
my_takeWhile bl []= []
my_takeWhile bl (x:xs)= if bl x then x:my_takeWhile bl xs
else []

--  my_takeWhile (>3) [1,2,3,4,5]
--[]
-- my_takeWhile odd [1,3,5,7,9,10,11,13,15,17]
-- [1,3,5,7,9]

my_break :: (a -> Bool) -> [a] -> ([a], [a])
my_break bl []=([],[])
my_break bl l=(first,second) where
  first =bhelper bl l
  second=bhelper2 bl l     where
  bhelper bl []=[]
  bhelper bl (x:xs)=if not(bl x) then x:bhelper bl xs else []
  bhelper2 bl []=[]
  bhelper2 bl (x:xs)= if bl x then (x:xs) else bhelper2 bl xs

-- my_break (3==) [1,2,3,4,5] 
-- ([1,2],[3,4,5])
-- my_break (1==) [1,2,3,4,5]
-- ([],[1,2,3,4,5])

-- Implement the Prelude functions and, or, concat using foldr

my_and :: [Bool] -> Bool
my_and =foldr (&&) True

-- my_and [True,True,False,True]
-- False

--  my_and [True,True,True]
-- True

my_or :: [Bool] -> Bool
my_or = foldr (||) False 


-- my_or [False,False,False,False] 
--False

-- my_or [True,True,True,False]
-- True

--my_or [True,True,True] 
-- True

my_concat :: [[a]] -> [a]
my_concat = foldr (++) []

-- my_concat [[1,2,3], [1,2,3]]
-- [1,2,3,1,2,3]

-- Implement the Prelude functions sum, product, reverse using foldl

my_sum :: Num a => [a] -> a
my_sum  = foldl (+) 0

--  my_sum [1,2,3,1,2,3]
-- 12

my_product :: Num a => [a] -> a
my_product = foldl (*) 1

-- my_product [1,2,3,1,2,3]
-- 36

my_reverse :: [a] -> [a]
my_reverse xs = foldl (\a x-> x : a) [] xs

-- my_reverse [1,2,3,1,2,3]
-- [3,2,1,3,2,1]

---- Part 4: Extra Credit ----------------

-- Convert a Tree into an equivalent Tree2, IF POSSIBLE. That is, given t1,
-- return t2 such that conv21 t2 = t1, if it exists. (In math, this is called
-- the "inverse image" of the function conv21.)  Thus, if conv21 t2 = t1, then
-- it should be that conv 12 t1 = Just t2. If there does not exist such a t2,
-- then conv12 t1 = Nothing. Do some examples on paper first so you can get a
-- sense of when this conversion is possible.
all_child_leaves :: Tree a -> Bool
all_child_leaves Empty=False
all_child_leaves (Node a Empty Empty)=True
all_child_leaves (Node a Empty c) =False
all_child_leaves (Node a b Empty)=False 
all_child_leaves (Node a b c)=all_child_leaves b && all_child_leaves c

conv12 :: Tree a -> Maybe (Tree2 a)
conv12 Empty = Nothing
conv12 (Node a Empty Empty)= Just (Leaf a)
conv12 (Node a Empty b)=Nothing
conv12 (Node a b Empty)=Nothing
conv12 (Node a b c)= if not (all_child_leaves b && all_child_leaves c ) then Nothing
else
  Just (Node2 a (conv b) (conv c)) where
  conv (Node a Empty Empty)= Leaf a
  conv (Node a b c)=Node2 a (conv b) (conv c)

-- conv12 (Node 1 (Node 2 Empty Empty) (Node 3 Empty (Node 6 Empty Empty)))
-- Nothing
-- conv12 (Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty))
-- Just (Node2 1 (Leaf 2) (Leaf 3))



-- Binary Search Trees. Determine, by making only ONE PASS through a tree,
-- whether or not it's a Binary Search Tree, which means that for every
-- Node a t1 t2 in the tree, every element in t1 is strictly less than a and
-- every element in t2 is strictly greater than a. Complete this for both
-- Tree a and Tree2 a.

-- Hint: use a helper function that keeps track of the range of allowable
-- element values as you descend through the tree. For this, use the following
-- extended integers, which add negative and positvie infintiies to Int:

data ExtInt = NegInf | Fin Int | PosInf deriving Eq

instance Show ExtInt where
  show NegInf     = "-oo"
  show (Fin n) = show n
  show PosInf     = "+oo"

instance Ord ExtInt where
  compare NegInf  NegInf  = EQ
  compare NegInf  _       = LT
  compare (Fin n) (Fin m) = compare n m
  compare (Fin n) PosInf  = LT
  compare PosInf  PosInf  = EQ
  compare _       _       = GT
  -- Note: defining compare automatically defines <, <=, >, >=, ==, /=
  
bst :: Tree Int -> Bool
bst Empty=True
bst (Node a Empty Empty)=True
bst (Node a b c)= bsth b a == LT && bsth c a ==GT && bst b && bst c where
  bsth Empty x= GT
  bsth (Node a b c) x=compare a x 

--  bst (Node 5 (Node 3 (Node 1 Empty Empty) (Node 4 Empty Empty)) (Node 8 (Node 7 Empty Empty) (Node 9 Empty Empty)))
-- True
-- bst (Node 5 (Node 3 (Node 1 Empty Empty) (Node 4 Empty Empty)) (Node 8 (Node 17 Empty Empty) (Node 9 Empty Empty)))
-- False


bst2 :: Tree2 Int -> Bool
bst2 (Leaf a)= True
bst2 (Node2 a b c)= bst2h b a==LT && bst2h c a == GT && bst2 b && bst2 c where
  bst2h (Leaf a) x=compare a x 
  bst2h (Node2 a b c) x= compare a x

  -- bst2 (Node2 5 (Node2 3 (Leaf 1) (Leaf 4)) (Node2 8 (Leaf 7) (Leaf 9)))
  -- True
  -- bst2 (Node2 5 (Node2 3 (Leaf 1) (Leaf 4)) (Node2 8 (Leaf 17) (Leaf 9)))
 -- False