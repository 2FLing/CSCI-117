tst :: Int -> Int
tst n
  | n == 0 = 0
  | n == 1 = 0
  | n == 2 = 1
  | otherwise = tst (n-2)+tst(n-1)+2