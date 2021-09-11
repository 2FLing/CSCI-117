module Fraction (Fraction, frac) where

-- Fraction type. ADT maintains the INVARIANT that every fraction Frac n m
-- satisfies m > 0 and gcd n m == 1. For fractions satisfying this invariant
-- equality is the same as literal equality (hence "deriving Eq")

data Fraction = Frac Integer Integer deriving Eq



-- Public constructor: take two integers, n and m, and construct a fraction
-- representing n/m that satisfies the invariant, if possible
frac :: Integer -> Integer -> Maybe Fraction
frac = undefined


-- Show instance that outputs Frac n m as n/m

-- Ord instance for Fraction

-- Num instance for Fraction
