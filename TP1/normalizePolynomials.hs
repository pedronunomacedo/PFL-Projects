import Data.Char

data Expo = Expo { var :: Char, exponent :: Integer } deriving (Show)
data Term = Term { number :: Float, expos :: [Expo] } deriving (Show)

testExpo :: Char -> Integer -> Expo
testExpo var exponent = Expo var exponent

testTerm :: Float -> [Expo] -> Term
testTerm number l = Term number l


--------------- Divide the given array in string parts ---------------
mainFunction :: [Char] -> [[Char]]
mainFunction l
  | (head newl == '+' || head newl == '-') = splitArray newl
  | otherwise = splitArray ('+':newl)
  where newl = (filter (\x -> (x /=' ')) l)

{-
mainFunction "0*x^2 + 2*y + 5*z + y + 7*y^2"
["+0*x^2","+2*y","+5*z","+y","+7*y^2","+2"]
-}

splitArray :: [Char] -> [[Char]]
splitArray [] = [[]]
splitArray [x] = []
splitArray l = (splitPair l):(splitArray (makeArray l 0))

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

takeExpoNum :: [Char] -> [Char]
takeExpoNum [x] = [x]
takeExpoNum (x:xs) = x:(takeExpoNum xs)

--"4*x^2*y^2" [Expo = {var: x, expoente: 2}, Expo = {var: y, expoente: 2}]
makeExpos :: [Char] -> [Expo]
makeExpos l = [inExpo ( takeWhile (/='*') (tail (dropWhile (/= '*') l)) )]++[inExpo ( dropWhile (/='*') (tail(dropWhile (/= '*') l)) )]

inExpo :: [Char] -> Expo
inExpo [] = Expo ' ' 0
inExpo [x] = Expo x 1
inExpo (x:y)
  | (isAlpha x) = if (head y == '^') then Expo x (read (takeExpoNum (tail y))::Integer) else Expo x 1
  | otherwise = inExpo y

takeNum :: [Char] -> [Char]
takeNum [x] = [x]
takeNum x = takeWhile (/='*') x

inTerm :: [Char] -> Term
inTerm [] = Term 0 []
inTerm [x] = Term (read [x] :: Float) []
inTerm x = Term (read (takeNum x) :: Float) []



--------------- Transform the list of strings in [(num, letter, grau),...] ---------------
searchForTimes :: [Char] -> Bool
searchForTimes str = if (length (filter (=='*') str) /= 0) then True else False

searchForPower :: [Char] -> Bool
searchForPower str = if (length (filter (=='^') str) /= 0) then True else False

readAfterTimes :: [Char] -> Int -> Int
readAfterTimes [] _ = 0
readAfterTimes [x] _ = digitToInt x
readAfterTimes (x:xs) b
  | (x == '*') = readAfterTimes xs 1
  | (x /= '*' && b == 1) = (readAfterTimes xs 1) * 10 + (digitToInt x)
  | otherwise = readAfterTimes xs 0
