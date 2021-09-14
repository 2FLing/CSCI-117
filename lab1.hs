-- CSci 117, Lab 1:  Introduction to Haskell

---------------- Part 1 ----------------

-- Work through Chapters 1 - 3 of LYaH. Type in the examples and make
-- sure you understand the results.  Ask questions about anything you
-- don't understand! This is your chance to get off to a good start
-- understanding Haskell.
doubleMe :: Num a => a -> a
doubleMe x = x+x

doubleUs :: Num a => a -> a -> a
doubleUs x y = x*2 + y*2

doubleSmallNumber :: (Ord a, Num a) => a -> a
doubleSmallNumber x = if x > 100 
    then x
    else x*2

doubleSmallNumber' :: (Num a, Ord a) => a -> a
doubleSmallNumber' x = (if x >100 then x else x*2)+1

---------------- Part 2 ----------------

-- The Haskell Prelude has a lot of useful built-in functions related
-- to numbers and lists.  In Part 2 of this lab, you will catalog many
-- of these functions.

-- Below is the definition of a new Color type (also called an
-- "enumeration type").  You will be using this, when you can, in
-- experimenting with the functions and operators below.
data Color = Red | Orange | Yellow | Green | Blue | Violet
     deriving (Show, Eq, Ord, Enum)

-- For each of the Prelude functions listed below, give its type,
-- describe briefly in your own words what the function does, answer
-- any questions specified, and give several examples of its use,
-- including examples involving the Color type, if appropriate (note
-- that Color, by the deriving clause, is an Eq, Ord, and Enum type).
-- Include as many examples as necessary to illustration all of the
-- features of the function.  Put your answers inside {- -} comments.
-- I've done the first one for you (note that "Î»: " is my ghci prompt).


-- succ, pred ----------------------------------------------------------------

{- 
succ :: Enum a => a -> a
pred :: Enum a => a -> a

For any Enum type, succ gives the next element of the type after the
given one, and pred gives the previous. Asking for the succ of the
last element of the type, or the pred of the first element of the type
results in an error.

Î»: succ 5
6
Î»: succ 'd'
'e'
Î»: succ False
True
Î»: succ True
*** Exception: Prelude.Enum.Bool.succ: bad argument
Î»: succ Orange
Yellow
Î»: succ Violet
*** Exception: succ{Color}: tried to take `succ' of last tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
Î»: pred 6
5
Î»: pred 'e'
'd'
Î»: pred True
False
Î»: pred False
*** Exception: Prelude.Enum.Bool.pred: bad argument
Î»: pred Orange
Red
Î»: pred Red
*** Exception: pred{Color}: tried to take `pred' of first tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
-}


-- toEnum, fromEnum, enumFrom, enumFromThen, enumFromTo, enumFromThenTo -------
-- As one of your examples, try  (toEnum 3) :: Color --------------------------

-- for the toEnum, it returns the item that at the given argument position of the enumeration.
-- *Main>   
-- Green

-- for the fromEnum, it returns the position of the given argument that in an enumeration.
-- *Main> fromEnum Green
-- 3

-- for the enumFrom, it returns an array that begin with the given argument from the enumeration.
-- *Main> enumFrom Orange
-- [Orange,Yellow,Green,Blue,Violet]
-- *Main> enumFrom Red   
-- [Red,Orange,Yellow,Green,Blue,Violet]

-- for the enumFromThen, it returns an array that starting with the first given argument and the second argument,
-- and then for the rest member in the array it will be the rest members in the enumeration but with the distance as
-- the first argument and the second argument.
-- *Main> enumFromThen Red Yellow
-- [Red,Yellow,Blue]

-- for the enumFromTo, it returns an array that starting with the first argument and ending with the second argument with
-- the same order the arguments in the enumeration.
-- *Main> enumFromTo Red Blue
-- [Red,Orange,Yellow,Green,Blue]

-- fot he enumFromThenTo, it returns an array that starts with the first argument and the second argument, ending before the third argument
-- but with the same distance as the first argument and the second argument of the enumeration.
-- *Main> enumFromThenTo Red Yellow Violet
-- [Red,Yellow,Blue]
-- *Main> enumFromThenTo Red Orange  Violet
-- [Red,Orange,Yellow,Green,Blue,Violet]

-- ==, /= ---------------------------------------------------------------------

-- for ==, it returns a boolean value that determind if two variables are equal.
-- However, the argument must be the same type in order to be compareable.
-- *Main> 1 == 1
-- True
-- *Main> 1 == 2
-- False
-- *Main> 1 == "t"
-- <interactive>:24:1: error:
--    * No instance for (Num [Char]) arising from the literal `1'

-- for /=. it returns a boolean value that determind if two vairables are not equal.
-- however, the agument must be the same type in order to be comparebale.
-- *Main> 1 /=2
-- True   
-- *Main> 1 /= 1
-- False  
-- *Main> 1 /= 'a'
-- <interactive>:4:1: error:
-- * No instance for (Num Char) arising from the literal `1'
-- * In the first argument of `(/=)', namely `1'


-- quot, div (Q: what is the difference? Hint: negative numbers) --------------

-- for quot, when it is doing the division, it towards to truncated the result
-- toward zero.
-- *Main> quot (-3) 2
-- -1

-- for div, when it is doing the division, it towards to truncated the result
-- toward negative infinity.
-- *Main> div (-3) 2
-- -2

-- rem, mod  (Q: what is the difference? Hint: negative numbers) --------------

-- for rem, it will return the remainder of the division.
-- the result will only be negative when the dividend is negative.
-- *Main> rem 3 (-2)
-- 1
-- *Main> rem (-2) 3
-- -2

-- for mod, it will return the remainder of the division.
-- the result will only be negative when the divisor is negative.
-- *Main> mod 3 (-2)
-- -1
-- *Main> mod (-3) 2
-- 1

-- quotRem, divMod ------------------------------------------------------------

-- for quotRem, it returns a tuple, the first element will be the result of the division
-- the second element will be the remainder of the division. Also, it tends to make the remainder
-- bigger but quotient smaller.
-- quotRem 13 (-5) 
-- (-2,3)

-- for divMod, it returns a tuple, the first element will be the result of the division, 
-- the second element will be the remainder of the division. Also, it tends to make the remainder
-- smaller but quotient bigger.
-- *Main> divMod 13 (-5)
-- (-3,-2)

-- &&, || ---------------------------------------------------------------------

-- && is the logic and
-- *Main> True && True
-- True
-- *Main> True && False
-- False

-- ++ -------------------------------------------------------------------------

-- ++ can combine two lists together.
-- *Main> [1,2,3] ++ [4,5,6]
-- [1,2,3,4,5,6]

-- compare --------------------------------------------------------------------

-- compare compares the first argument to the second argument, and returns 'LT'
-- if the first argument is less than second argument, 'GT' for the greater case
-- 'EQ' for the equal case.
-- *Main> compare 1 2
-- LT
-- *Main> compare 2 1
-- GT
-- *Main> compare 1 1
-- EQ

-- <, > -----------------------------------------------------------------------
-- <> can combine to lists together.
-- *Main> [1,2,3] <> [3,4,5]
-- [1,2,3,3,4,5]

-- max, min -------------------------------------------------------------------
-- max compares two arguments, and return the bigger one
-- *Main> max 1 3
-- 3
-- *Main> max (-1) 2
-- 2

-- min compares two arguments, and return the smaller one
-- *Main> min 1 3
-- 1
-- *Main> min (-1) 2
-- -1

-- ^ --------------------------------------------------------------------------
-- ^ takes the second argument as the power of the first argument and return the result
-- *Main> 2^3
-- 8

-- concat ---------------------------------------------------------------------
-- concat takes a list of lists and concatenates them.
-- *Main> concat [[1,2,3],[4,5,6]]
-- [1,2,3,4,5,6]

-- const ----------------------------------------------------------------------
-- const takes two arguments, and zlawys return the first one.
-- *Main> const 12 99
-- 12
-- *Main> const 99 12
-- 99

-- cycle ----------------------------------------------------------------------
-- cycle takes a list of elements and return a finite list with looping all elements from the argument.
-- *Main> take 10 (cycle [1,2,3])
-- [1,2,3,1,2,3,1,2,3,1]
-- *Main> take 10 (cycle "AB")   
-- "ABABABABAB"

-- drop, take -----------------------------------------------------------------
-- drop takes two arguments, first one is an integer, second one is a list.
-- then it will remove as many as the first argument elements from second argument, and 
-- return the result.
-- *Main> drop 3 [1,2,3,4]
-- [4]
-- *Main> drop 3 [1,2,3,4,5,6]
-- [4,5,6]

-- take takes two arguments, frist one is an integer, second one is a list.
-- then it will return a list that the first argument determinds the number of the element
-- taken from the second argument. If the number is larger then the length of the list, then
-- it will return the whole list.
-- *Main> take 3 [1,2,3,4]
-- [1,2,3]
-- *Main> take 5 [1,2,3,4]
-- [1,2,3,4]

-- elem -----------------------------------------------------------------------
-- elem takes two arguments, if the first argument is member of the second argument
-- then returns true otherwise returns false
-- *Main> elem 1 [1,2,3]
-- True
-- *Main> elem 4 [1,2,3]
-- False

-- even -----------------------------------------------------------------------
-- even takes one argument, if the argument is an even number then returns true,
-- otherwise return false
-- *Main> even 12
-- True
-- *Main> even 11
-- False

-- fst ------------------------------------------------------------------------
-- fst takes a tuple as argument, and returns the first element of the tuple
-- *Main> fst (1,2)
-- 1
-- *Main> fst (3,4)
-- 3

-- gcd ------------------------------------------------------------------------
-- gcd takes two nunbers as its arguments, and returns their greatest common divisor
-- *Main> gcd 12 13
-- 1
-- *Main> gcd 14 12
-- 2

-- head -----------------------------------------------------------------------
-- head takes a list as argument and return the first element of the list
-- *Main> head [1,2,3,4]
-- 1
-- *Main> head [3,4,5]
-- 3

-- id -------------------------------------------------------------------------
-- The id function takes a value and returns it unchanged
-- *Main> id "hello"
-- "hello"
-- *Main> id 3
-- 3

-- init -----------------------------------------------------------------------
-- init takes a list as argument and return the list but without the last element.
-- *Main> init [1,2,3]
-- [1,2]
-- *Main> init "hello"
-- "hell"

-- last -----------------------------------------------------------------------
-- last takes a list as argument and return the last element in that list.
-- *Main> last [1,2,3]
-- 3
-- *Main> last "hello"
-- 'o'

-- lcm ------------------------------------------------------------------------
-- lcm takes two numbers as arguments, and returns their lowest common mutiple
-- *Main> lcm 3 6
-- 6
-- *Main> lcm 3 7
-- 21

-- length ---------------------------------------------------------------------
--length takes a list as argument and returns the number of the element that 
-- the list containing
-- *Main> length "hello"
-- 5
-- *Main> length [1,2,3,4]
-- 4

-- null -----------------------------------------------------------------------
-- null takse a list as argument and returns true if the list is empty otherwise
-- returns false
-- *Main> null []
-- True
-- *Main> null [1,2,3,4]
-- False

-- odd ------------------------------------------------------------------------
-- odd takes a number as argument and returns true if it is an odd number, otherwise
-- returns false
-- *Main> odd 7
-- True
-- *Main> odd 8
-- False

-- repeat ------  ---------------------------------------------------------------
-- repeat takes a value as argument and return a list that looping with that value 
-- *Main> take 3 (repeat "A") 
-- ["A","A","A"]
-- *Main> take 3 (repeat 1)   
-- [1,1,1]
-- *Main> take 3 (repeat "Ab")
-- ["Ab","Ab","Ab"]

-- replicate ------------------------------------------------------------------
-- replicate takes a number and a value as its arguments, and returns a list
-- that containing that number of that value.
-- *Main> replicate 3 4
-- [4,4,4]
-- *Main> replicate 3 'A'
-- "AAA"

-- reverse --------------------------------------------------------------------
-- reverse takes a list as argument and then returns the reversed version
-- *Main> reverse "ABC"
-- "CBA"
-- *Main> reverse [1,2,3]
-- [3,2,1]

-- snd ------------------------------------------------------------------------
-- snd takes a tuple as argument and returns the second element of the tuple
-- *Main> snd (1,2)
-- 2

-- splitAt --------------------------------------------------------------------
-- splitAt takes a number as first arguemnt and list as second argument, and
-- return a tuple that first element is a list as same as second argument but
-- its length determind by first argument, and the second element is the rest of
-- the list from second argument.
-- *Main> splitAt 3 [1,2,3,4]
-- ([1,2,3],[4])
-- *Main> splitAt 2 [1,2,5,4]
-- ([1,2],[5,4])

-- zip ------------------------------------------------------------------------
-- zip takes two lists as its arguemnt and it makes a list of tuples, 
-- each tuple containing elements of both lists that are at the same position
-- *Main> zip [1,2,3] [4,5,6]
-- [(1,4),(2,5),(3,6)]


-- The rest of these are higher-order, i.e., they take functions as
-- arguments. This means that you'll need to "construct" functions to
-- provide as arguments if you want to test them.

-- all, any -------------------------------------------------------------------

-- all takes a condition and a list as arguments, if every element in the list
-- satisfied with the condition then it returns true, otherwise returns false.
-- *Main> all (>3) [1,2,3,4,5]
-- False
-- *Main> all (<6) [1,2,3,4,5]
-- True

-- any takes a condition and a list as arguments, if there is any element in the
-- list satisfied with the condition then it returns true, otherwise returns false.
-- *Main> any (>3) [1,2,3,4,5]
-- True
-- *Main> any (<0) [1,2,3,4,5]
-- False

-- break ----------------------------------------------------------------------

-- break takes a condition and a list as arguments and breaks the list at the 
-- condition boundary
-- *Main> break (3==) [1,2,3,4]
-- ([1,2],[3,4])

-- dropWhile, takeWhile -------------------------------------------------------

-- dropWhile takes a condition and a list as arguments, and it drops off the element
-- in the list that meets the condition.
-- *Main> dropWhile (<3) [1,2,3,4,5]
-- [3,4,5]

-- takeWhile takes a condition and a list as argument, it takes the element that 
-- meeting the condition, once the condition fail, it stops processing.

-- *Main> takeWhile (<3) [1,2,3,4,5]
-- [1,2]
-- *Main> takeWhile (>3) [1,2,3,4,5]
-- []

-- filter ---------------------------------------------------------------------


-- filter takes a conditon and a list as arguments, it takes the elements from the
-- list that meeting the condition.
-- *Main> filter (<3) [1,2,3,4,5]
-- [1,2]
-- *Main> filter (==3) [1,2,3,4,5]
-- [3]

-- iterate --------------------------------------------------------------------

-- iterate takes a formula and a number as arguments, it returns an infinite list that
-- starts from the given number and caculates the follwing numbers by applying the formula.
-- *Main> take 3 (iterate (2*)1 )
-- [1,2,4]
-- *Main> take 3 (iterate (2*)2 )
-- [2,4,8]

-- map ------------------------------------------------------------------------

-- map takes a fomular and a list as arguments and it applys the fomular to every
-- elements that in the list.
-- *Main> map (+1) [1,2,3,4]
-- [2,3,4,5]
-- span -----------------------------------------------------------------------

-- span takse a condition and a list as arguments, it returns a tuple that
-- first item is the element that meeting the conditoin which from the list,
-- and second item is the rest of the list
-- *Main> span (<3) [1,2,3,4,5]
-- ([1,2],[3,4,5])
