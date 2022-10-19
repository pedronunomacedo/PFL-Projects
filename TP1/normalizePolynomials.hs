import Data.Char
import Data.List


------------------ Types, data and variables -------------------------

data Expo = Expo { var :: Char, exponant :: Integer } deriving (Show, Eq)
data Term = Term { number :: Float, expos :: [Expo] } deriving (Show, Eq)





------------------------- mainFunction -----------------------------

mainFunction :: [Char] -> [[Char]]
mainFunction l
  | (head newl == '+' || head newl == '-') = splitArray newl
  | otherwise = splitArray ('+':newl)
  where newl = (filter (\x -> (x /=' ')) l)


mainFunction1 :: [Char] -> [Term]
mainFunction1 l = option1 (allInTerm (mainFunction l))


main = do
  putStrLn ""
  putStrLn " Escolha uma opção: "
  putStrLn ""
  putStrLn " [1] - normalizar polinómio"
  putStrLn " [2] - adicionar polinómios"
  putStrLn " [3] - multiplicar polinómios"
  putStrLn " [4] - derivada de polinómio"
  putStrLn ""

  opção <- getLine

  putStrLn ""

  do
    if (opção == "1")
      then do
            putStrLn ("Escreva o polinómio: ")
            polinomio <- getLine
            putStrLn ""
            print $ mainFunction1 polinomio
      else if (opção == "2")
        then putStrLn ("escolheu a opcao " ++ opção ++ "\n")
        else if (opção == "3")
          then putStrLn ("escolheu a opcao " ++ opção ++ "\n")
          else if (opção == "4")
            then putStrLn ("escolheu a opcao " ++ opção ++ "\n")
            else error "Escolha um número entre 1 e 4"


{-
mainFunction "0*x^2 + 2*y + 5*z + y + 7*y^2"
["+0*x^2","+2*y","+5*z","+y","+7*y^2","+2"]
-}


{-
allInTerm ["+3*x^2","+2*y","+5*z","+y","+7*y^2"]
[Term {number = 3.0, expos = [Expo {var = 'x', exponant = 2}]},Term {number = 2.0, expos = [Expo {var = 'y', exponant = 1}]},Term {number = 5.0, expos = [Expo {var = 'z', exponant = 1}]},Term {number = 1.0, expos = [Expo {var = 'y', exponant = 1}]},Term {number = 7.0, expos = [Expo {var = 'y', exponant = 2}]}]
-}





-------------------------------- Opção 1 ------------------------------

option1 :: [Term] -> [Term]
option1 [] = []
option1 l = removeZeros l

removeZeros :: [Term] -> [Term]
removeZeros [] = []
removeZeros l = removeZeroExponants (removeZeroNumbersTerms l)

removeZeroExponants :: [Term] -> [Term]
removeZeroExponants [] = []
removeZeroExponants [x] = [Term (number x) (map (\y -> if (exponant y == 0) then (Expo ' ' 0) else y) (expos x))]
removeZeroExponants (x:xs) = (Term (number x) (filter (\x -> (exponant x /= 0)) (expos x))):(removeZeroExponants xs)

removeZeroNumbersTerms :: [Term] -> [Term]
removeZeroNumbersTerms [] = []
removeZeroNumbersTerms l = filter (\exp -> (number exp /= 0.0)) l

{-}
addTermsWithSameExponent :: [Term] -> [Term]
addTermsWithSameExponent [] = []
addTermsWithSameExponent l = (addTermsWithSameExponent (removeTermsWithSameExpos l (expos ti)))
  where ti = head l

removeTermsWithSameExpos :: [Term] -> Expo -> [Term]
removeTermsWithSameExpos [] _ = []
removeTermsWithSameExpos terms exps = filter (\t -> ((expos t) /= exps)) terms

sumNumOfSameExponent :: Term -> Term -> Float
sumNumOfSameExponent a b = (number a) + (number b)
-}

sameVarSumExponents :: [Expo] -> [Expo]
sameVarSumExponents [] = []
sameVarSumExponents (x:xs)
  | (var x == var (head xs)) = (x:xs)++[Expo (var x) ((exponant x) + (exponant (head xs)))]
  | otherwise = sameVarSumExponents xs





----------------- Sort expos of one term ---------------------

sortExpos :: Expo -> Expo -> Ordering
sortExpos exp1 exp2
  | (exponant exp1 < exponant exp2) = GT
  | otherwise = LT

sortByEx :: [Expo] -> [Expo] -- Expo {var, exponant}
sortByEx [] = []
sortByEx l = sortBy (sortExpos) l

sortLetters :: Expo -> Expo -> Ordering
sortLetters letter1 letter2
  | (var (letter1) < var (letter2)) = LT
  | otherwise = GT

sortB :: [Expo] -> [Expo]
sortB [] = []
sortB lista = sortBy (sortLetters) (highestTerm : [x | x <- (tail lista), (exponant x) == (exponant highestTerm)])
              ++ sortB [x | x <- lista, (exponant x) /= (exponant highestTerm)]
              where highestTerm = (head lista)

sortFunction :: [Expo] -> [Expo]
sortFunction [] = []
sortFunction lista = sortB (sortByEx lista)





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


orderExpos :: [Expo] -> [Expo]
orderExpos [] = []
orderExpos [x] = [x]
orderExpos (x:xs)
  | (ord(var x) < ord(var (head xs))) = [x]++(orderExpos xs)
  | otherwise = (orderExpos xs)++[x]
