import Data.Char


------------------ Types, data and variables -------------------------

data Expo = Expo { var :: Char, exponent :: Integer } deriving (Show)
data Term = Term { number :: Float, expos :: [Expo] } deriving (Show)





------------------------- mainFunction -----------------------------

mainFunction :: [Char] -> [[Char]]
mainFunction l
  | (head newl == '+' || head newl == '-') = splitArray newl
  | otherwise = splitArray ('+':newl)
  where newl = (filter (\x -> (x /=' ')) l)




{-
mainFunction "0*x^2 + 2*y + 5*z + y + 7*y^2"
["+0*x^2","+2*y","+5*z","+y","+7*y^2","+2"]
-}


{-
allInTerm ["-0*x^2","5*z","-7*y^4"]
[Term {number = -0.0, expos = [Expo {var = 'x', exponent = 2}]},Term {number = 5.0, expos = [Expo {var = 'z', exponent = 1}]},Term {number = -7.0, expos = [Expo {var = 'y', exponent = 4}]}]
-}


-- ERROS:
          -- inTerm "x"   --> se for so uma variavel assim sem nada da erro
          -- allInTerm ["-0*x^2","+5*z","-7*y^4"]  --> se tiver um "mais" (+) antes dos numeros dá mal, se nao houver ou for um "menos" (-) dá certo




--------------- Divide the given array in string parts ---------------

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





  ----------------- Transform strings into TERM ---------------------

myconcat :: [[a]] -> [a]
myconcat [] = []
myconcat (x:xs) = x ++ myconcat xs


takeExpoNum :: [Char] -> [Char]
takeExpoNum [x] = [x]
takeExpoNum (x:xs) = x:(takeExpoNum xs)


--"4*x^2*y^3*z^4" [Expo = {var: x, expoente: 2}, Expo = {var: y, expoente: 2}]
makeExpos :: [Char] -> [Expo]
makeExpos [] = []
makeExpos [x] = [Expo x 1]
makeExpos (x:xs)
  | ((isAlpha x) && length (dropWhile (/='*') (x:xs)) == 0) = [inExpo (takeWhile (/='*') (x:xs)) ]
  | (length (tail (dropWhile (/='*') (x:xs))) == 0) = []
  | otherwise = [inExpo (takeWhile (/='*') (x:xs)) ]++
                myconcat[makeExpos ( tail(dropWhile (/='*') (x:xs)))]


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
inTerm (x:xs)
  | ((x == '+') && not('*' `elem` xs) && isDigit(head xs)) = Term (read(xs)::Float) [Expo ' ' 0]
  | ((x == '-') && not('*' `elem` xs) && isDigit(head xs)) = Term (read(x:xs)::Float) [Expo ' ' 0]
  | (x == '+' && isDigit(head xs)) = Term (read(takeNum xs)::Float) (makeExpos (tail(dropWhile (/='*') xs)))
  | (x == '-' && isDigit(head xs)) = Term (read(takeNum (x:xs))::Float) (makeExpos (tail(dropWhile (/='*') xs)))
  | (x == '+') = Term 1 (makeExpos xs)
  | (x == '-') = Term (-1) (makeExpos xs)
  | otherwise = Term (read [x] :: Float) []

allInTerm :: [[Char]] -> [Term]
allInTerm [] = []
allInTerm (x:xs) = [inTerm x]++(allInTerm xs)




---------- Transform the list of strings in [(num, letter, grau),...] --------

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
