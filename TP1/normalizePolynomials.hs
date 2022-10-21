import Data.Char
import Data.List


------------------ Types, data and variables -------------------------

data Expo = Expo { var :: Char, exponant :: Integer } deriving (Show, Eq)
data Term = Term { number :: Float, expos :: [Expo] } deriving (Show, Eq)





------------------------- mainFunction -----------------------------

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
        putStrLn ("Polinómio normalizado: ")
        print $ option1 polinomio
      else if (opção == "2")
        then do
          putStrLn ("Escreva o primeiro polinómio")
          polinomio1 <- getLine
          putStrLn ""
          putStrLn ("Escreva o segundo polinómio")
          polinomio2 <- getLine
          putStrLn ""
          putStrLn ("Resultado: ")
          print $ option2 polinomio1 polinomio2
        else if (opção == "3")
          then putStrLn ("escolheu a opcao " ++ opção ++ "\n")
          else if (opção == "4")
            then putStrLn ("escolheu a opcao " ++ opção ++ "\n")
            else error "Escolha um número entre 1 e 4"













-------------------------------- Opção 1 ------------------------------

option1 :: [Char] -> [Char]
option1 l = allTermsToString (sortAllListByExpos (addTermsWithSameExponents (sortAllListByExpos (sameVarSumExponentsForAllTerms (removeZeros (sortFunctionForAllTerms(allInTerm (divideString l))))))))


removeZeros :: [Term] -> [Term]
removeZeros [] = []
removeZeros l = removeZeroExponants (removeZeroNumbersTerms l)

removeZeroExponants :: [Term] -> [Term]
removeZeroExponants [] = []
removeZeroExponants (x:xs) = (Term (number x) (mapExpos (expos x))):(removeZeroExponants xs)

mapExpos :: [Expo] -> [Expo]
mapExpos [x] = if (exponant x == 0) then [Expo ' ' 0] else [x]
mapExpos (x:xs)
  | (exponant x == 0) = (Expo ' ' 0):(mapExpos xs)
  | otherwise = x:(mapExpos xs)

removeZeroNumbersTerms :: [Term] -> [Term]
removeZeroNumbersTerms [] = []
removeZeroNumbersTerms l = filter (\exp -> (number exp /= 0.0)) l

sumExpos :: [Expo] -> Integer
sumExpos [] = 0
sumExpos [x] = exponant x
sumExpos (x:xs) = (exponant x) + sumExpos xs

sameVarSumExponents :: [Expo] -> [Expo]
sameVarSumExponents [] = []
sameVarSumExponents l = [Expo (var (head l)) (sumExpos (filter (\x -> (var (head l)) == (var x)) l))]++(sameVarSumExponents (filter (\x -> (var (head l)) /= (var x)) l))

sameVarSumExponentsForTerm :: Term -> Term
sameVarSumExponentsForTerm t = Term (number t) (sameVarSumExponents (expos t))

sameVarSumExponentsForAllTerms :: [Term] -> [Term]
sameVarSumExponentsForAllTerms [] = []
sameVarSumExponentsForAllTerms (x:xs) = (sameVarSumExponentsForTerm x):(sameVarSumExponentsForAllTerms xs)

sumTermOfSameExponent :: Term -> Term -> Term
sumTermOfSameExponent a b = Term ((number a) + (number b)) (expos a)

addTermsWithSameExponents :: [Term] -> [Term]
addTermsWithSameExponents [] = []
addTermsWithSameExponents [x] = [x]
addTermsWithSameExponents (x:xs) = if ((expos x) == (expos (head xs))) then addTermsWithSameExponents((sumTermOfSameExponent x (head xs)) : (tail xs)) else [x]++(addTermsWithSameExponents xs)


myinsert :: Term -> [Term] -> [Term]
myinsert n [] = [n]
myinsert n (x:xs)
  | ((ord (var (head (expos n)))) < (ord (var (head (expos x))))) = n:x:xs
  | (ord (var (head (expos n)))) == (ord (var (head (expos x)))) = if ((exponant (head (expos n))) >= (exponant (head (expos x)))) then (n:x:xs) else x:(myinsert n xs)
  | otherwise = x:(myinsert n xs)

sortAllListByExpos :: [Term] -> [Term]
sortAllListByExpos [] = []
sortAllListByExpos (x:xs) = myinsert x (sortAllListByExpos xs)







-------------------------------- Opção 2 ------------------------------

option2 :: [Char] -> [Char] -> [Char]
option2 a b
  | (head b == '-') = option1 (a ++ b)
  | otherwise = option1 (a ++ "+" ++ b)












  -------------------------------- Opção 3 ------------------------------
{-
option3 :: [Char] -> [Char] -> [Term]
option3 a b
-}





------------------------- Sort expos of all terms -----------------------

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

sortFunctionForTerm :: Term -> Term
sortFunctionForTerm t = Term (number t) (sortFunction (expos t))

sortFunctionForAllTerms :: [Term] -> [Term]
sortFunctionForAllTerms [] = []
sortFunctionForAllTerms (x:xs) = (sortFunctionForTerm x):(sortFunctionForAllTerms xs)




















--------------- Divide the given array in string parts ---------------

divideString :: [Char] -> [[Char]]
divideString l
  | (head newl == '+' || head newl == '-') = splitArray newl
  | otherwise = splitArray ('+':newl)
  where newl = (filter (\x -> (x /=' ')) l)

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













------------------------------- Term to String ------------------------

allTermsToString :: [Term] -> [Char]
allTermsToString [] = []
allTermsToString [x] = termToString x
allTermsToString (x:xs)
  | ((number (head xs)) < 0) = termToString x ++ " " ++ allTermsToString xs
  | otherwise = termToString x ++ " + " ++ allTermsToString xs

termToString :: Term -> [Char]
termToString t
  | ((head (expos t)) == Expo ' ' 0) = show(number t) ++ expoToString(expos t)
  | otherwise = show(number t)++"*"++expoToString(expos t)

expoToString :: [Expo] -> [Char]
expoToString [] = []
expoToString [x]
  | (x == Expo ' ' 0) = []
  | otherwise = [var x]++"^"++show(exponant x)
expoToString (x:xs) = ([var x]++"^"++show(exponant x))++"*"++(expoToString xs)
