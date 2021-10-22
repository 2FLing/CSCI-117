data Gen a = G (() -> (a, Gen a))

generate :: Int -> Gen Int
generate n = G (\_ -> (n, generate (n+1)))

gen_take :: Int -> Gen a -> [a]
gen_take 0 _ = []
gen_take n (G f) = let (x,g) = f () in x : gen_take (n-1) g    -- What's the type of f here? --  f will be (Int, Gen Int)

times :: Int -> Gen Int -> Gen Int
times n (G f) = let (x,g) = f () in G(\_ -> ((n*x),times n g))

merge :: Gen Int -> Gen Int -> Gen Int
merge (G f) (G p) = let (x,g) = f () in let (y,k) = p() in 
    if x < y then G (\_ -> (x,merge g (G p))) 
    else if y < x then G (\_ -> (y,merge k (G f))) 
    else  G (\_ -> (x, merge g k))

hamming :: Gen Int -> Gen Int
hamming (G f) = let (x,g) = f () in G (\_ -> (1,merge (times 2 (hamming g)) (merge (times 3 (hamming g)) (times 5 (hamming g)))))

l :: Gen Int
l = generate 1
y = hamming l