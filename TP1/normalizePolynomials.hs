import Data.Char

data Expo = Expo { var :: Char, exponent :: Integer }
data Term = Term { signal :: Char, number :: Float, expos :: [Expo] }

testExpo :: Char -> Integer -> Expo
testExpo var exponent = Expo var exponent

testTerm :: Char -> Float -> [Expo] -> Term
testTerm signal number l = Term signal number l


--------------- Divide the given array in string parts ---------------

splitArray :: [Char] -> [[Char]]
splitArray [] = [[]]
splitArray [x] = []
splitArray l = if ((head l) == '-') then (splitPair l):(splitArray (makeArray l 0)) else (splitPair l):(splitArray (makeArray l 0))


splitPair :: [Char] -> [Char]
splitPair [] = []
splitPair (x:xs)
  | (null xs) = [x]
  | (((head xs) == '+') || ((head xs) == '-')) = [x]
  | otherwise = [x] ++ (splitPair xs)

makeArray :: [Char] -> Integer -> [Char]
makeArray [] _ = []
makeArray [x] _ = [x]
makeArray (x:xs) num
  | (null xs) = [x]
  | ((((head xs) == '+') || ((head xs) == '-')) && num == 0) = makeArray xs 1
  | ((((head xs) /= '+') || ((head xs) /= '-')) && num == 0) = makeArray xs 0
  | otherwise = [x] ++ (makeArray xs 1)

--------------- Transform the list of strings in [(num, letter, grau),...] ---------------
searchForTimes :: [Char] -> Bool
searchForTimes [] = False
searchForTimes (x:xs)
  | (x == '*') = True
  | otherwise = searchForTimes xs

searchForPower :: [Char] -> Bool
searchForPower [] = False
searchForPower (x:xs)
  | (x == '^') = True
  | otherwise = searchForPower xs

readAfterTimes :: [Char] -> Int -> Int
readAfterTimes [] _ = 0
readAfterTimes [x] _ = digitToInt x
readAfterTimes (x:xs) b
  | (x == '*') = readAfterTimes xs 1
  | (x /= '*' && b == 1) = (readAfterTimes xs 1) * 10 + (digitToInt x)
  | otherwise = readAfterTimes xs 0



divideInTuples :: [Char] -> [Term]
divideInTuples = makeTuples (splitArray l)

makeTuples :: [[Char]] -> [Term]
makeTuples (x:xs) = 
  | (times == True) =
  where times = searchForTimes x
        power = searchForPower x
