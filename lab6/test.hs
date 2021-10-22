tst :: Int -> Int
tst n
  | n == 0 || n == 1 =0
  | n == 2 = 2
  | otherwise = help n where
    help n
      | n == 0 || n == 1 = 1
      | n == 2 = 2
      | otherwise = help (n - 1) + help (n - 2)+1