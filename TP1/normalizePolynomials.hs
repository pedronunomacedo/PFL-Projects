import Data.Char
import Data.List



------------------ Types, data and variables -------------------------

data Expo = Expo { var :: Char, exponant :: Integer } deriving (Show, Eq)
data Term = Term { number :: Float, expos :: [Expo] } deriving (Show, Eq)



------------------------- mainFunction -----------------------------

-- main function to start program and display options
main = do
  putStrLn ""
  putStrLn " Escolha uma opção: "
  putStrLn ""
  putStrLn " [1] - normalizar polinómio"
  putStrLn " [2] - adicionar polinómios"
  putStrLn " [3] - multiplicar polinómios"
  putStrLn " [4] - derivada de polinómio"
  putStrLn ""
  putStrLn "Opção: "
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
        putStrLn ""
      else if (opção == "2")
        then do
          putStrLn ("Escreva o primeiro polinómio: ")
          polinomio1 <- getLine
          putStrLn ""
          putStrLn ("Escreva o segundo polinómio: ")
          polinomio2 <- getLine
          putStrLn ""
          putStrLn ("Resultado: ")
          print $ option2 polinomio1 polinomio2
          putStrLn ""
        else if (opção == "3")
          then do
            putStrLn ("Escreva o primeiro polinómio: ")
            polinomio1 <- getLine
            putStrLn ""
            putStrLn ("Escreva o segundo polinómio: ")
            polinomio2 <- getLine
            putStrLn ""
            putStrLn ("Resultado: ")
            print $ option3 polinomio1 polinomio2
            putStrLn ""
          else if (opção == "4")
            then do
              putStrLn ("Escreva o polinómio: ")
              polinomio <- getLine
              putStrLn ""
              putStrLn ("Qual a variável pela qual quer derivar: ")
              variavel <- getLine
              putStrLn ""
              putStrLn ("Resultado: ")
              print $ option4 polinomio variavel
            else error "Escolha um número entre 1 e 4"



-------------------------------- Option 1 ------------------------------

-- function that displays the result of the option 1 and transforms the data in string to print
option1 :: [Char] -> [Char]
option1 l = allTermsToString (simplificar l)

-- function that calls all the functions that simplify a polynomial
simplificar :: [Char] -> [Term]
simplificar l = sortAllListByExpos (addTermsWithSameExponents (sortAllListByExpos (sameVarSumExponentsForAllTerms (removeZeros (sortFunctionForAllTerms(allInTerm (divideString l)))))))

--
removeZeros :: [Term] -> [Term]
removeZeros [] = []
removeZeros l = removeZeroExponants (removeZeroNumbersTerms l)

--removes variables if they have a zero exponant
removeZeroExponants :: [Term] -> [Term]
removeZeroExponants [] = []
removeZeroExponants (x:xs) = (Term (number x) (mapExpos (expos x))):(removeZeroExponants xs)

-- checks if exponant is zero so we can remove it
mapExpos :: [Expo] -> [Expo]
mapExpos [x] = if (exponant x == 0) then [Expo ' ' 0] else [x]
mapExpos (x:xs)
  | (exponant x == 0) = (Expo ' ' 0):(mapExpos xs)
  | otherwise = x:(mapExpos xs)

-- remove terms if their coeficient is zero
removeZeroNumbersTerms :: [Term] -> [Term]
removeZeroNumbersTerms [] = []
removeZeroNumbersTerms l = filter (\exp -> (number exp /= 0.0)) l

-- sums exponents
sumExpos :: [Expo] -> Integer
sumExpos [] = 0
sumExpos [x] = exponant x
sumExpos (x:xs) = (exponant x) + sumExpos xs

-- sums exponants if they have the same variable
sameVarSumExponents :: [Expo] -> [Expo]
sameVarSumExponents [] = []
sameVarSumExponents l = [Expo (var (head l)) (sumExpos (filter (\x -> (var (head l)) == (var x)) l))]++(sameVarSumExponents (filter (\x -> (var (head l)) /= (var x)) l))

-- applies the function above for the whole term
sameVarSumExponentsForTerm :: Term -> Term
sameVarSumExponentsForTerm t = Term (number t) (sameVarSumExponents (expos t))

-- -- applies the function above for the all the terms (the whole polynomial)
sameVarSumExponentsForAllTerms :: [Term] -> [Term]
sameVarSumExponentsForAllTerms [] = []
sameVarSumExponentsForAllTerms (x:xs) = (sameVarSumExponentsForTerm x):(sameVarSumExponentsForAllTerms xs)

-- sums the coeficients of two terms
sumTermOfSameExponent :: Term -> Term -> Term
sumTermOfSameExponent a b = Term ((number a) + (number b)) (expos a)

-- sums the coeficients of terms with the same variables and exponents
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

-- sorts the terms (whole polynomial) by variable and exponent
sortAllListByExpos :: [Term] -> [Term]
sortAllListByExpos [] = []
sortAllListByExpos (x:xs) = myinsert x (sortAllListByExpos xs)



-------------------------------- Option 2 ------------------------------

-- function that displays the result of the option 2
-- concatenates the two polynomials and calls option 1 function
option2 :: [Char] -> [Char] -> [Char]
option2 a b
  | (head b == '-') = option1 (a ++ b)
  | otherwise = option1 (a ++ "+" ++ b)



  -------------------------------- Option 3 ------------------------------

-- function that displays the result of the option 3
-- first normalizes both inputs and multiplies them and then normalizes the result again
option3 :: [Char] -> [Char] -> [Char]
option3 a b = allTermsToString(sortAllListByExpos (addTermsWithSameExponents (sortAllListByExpos (sameVarSumExponentsForAllTerms (removeZeros (sortFunctionForAllTerms(multiplyPolys simpA simpB)))))))
                where simpA = simplificar a
                      simpB = simplificar b

-- multiplies the coeficient of two terms and concatenates their variables and exponents
joinExpos :: Term -> Term -> Term
joinExpos p1 p2 = Term ((number p1) * (number p2)) ((expos p1)++(expos p2))

-- function that applies the distributive property of multiplication to the inputs
multiplyPolys :: [Term] -> [Term] -> [Term]
multiplyPolys pol1 pol2 = [ (joinExpos p1 p2)| p1 <- pol1, p2 <- pol2]



-------------------------------- Option 4 ------------------------------

-- function that displays the result of the option 4
-- first normalizes the polynomial and derivates it in order to the input variable and then normalizes the result again
option4 :: [Char] -> [Char] -> [Char]
option4 l v = option1 (allTermsToString (derivateExpo (simplificar l) (stringToChar v)))

-- changes the variable from string input to char
stringToChar :: [Char] -> Char
stringToChar [x] = x

-- function that derivates a monomial according to the input variable
derivateTerm :: Term -> Char -> Term
derivateTerm t ch
  | (length (filter (\x -> (var x ) == ch) charExpo)) == 0 = Term 0 [Expo ' ' 0]
  | ((length charExpo) == 0) = Term 0 []
  | ((length charExpo) /= 0 && (var (head charExpo)) == ' ') = Term 0 []
  | ((length charExpo) /= 0) = Term ((number t) * (fromIntegral (exponant expo))) ([Expo (var expo) ((exponant expo) - 1)]++notCharExpo)
  | otherwise = t
  where charExpo = (filter (\e -> (var e == ch)) (expos t))
        expo = (head (filter (\e -> (var e == ch)) (expos t)))
        notCharExpo = (filter (\e -> (var e /= ch)) (expos t))

-- Applies the above function to all the polynomials (whole string)
derivateExpo :: [Term] -> Char -> [Term]
derivateExpo [] _ = []
derivateExpo t ' ' = t
derivateExpo terms ch = map (\t -> (derivateTerm t ch)) terms



------------------------- Sort expos of all terms -----------------------

-- Sorts two Expos by exponent
sortExpos :: Expo -> Expo -> Ordering
sortExpos exp1 exp2
  | (exponant exp1 < exponant exp2) = GT
  | otherwise = LT

-- sorts all the Expos of a monomial by exponant
sortByEx :: [Expo] -> [Expo] -- Expo {var, exponant}
sortByEx [] = []
sortByEx l = sortBy (sortExpos) l

-- Sorts two Expos by variable by alphabetical order
sortLetters :: Expo -> Expo -> Ordering
sortLetters letter1 letter2
  | (var (letter1) < var (letter2)) = LT
  | otherwise = GT

-- Sorts all the Expos of a monomial by variable
sortB :: [Expo] -> [Expo]
sortB [] = []
sortB lista = sortBy (sortLetters) (highestTerm : [x | x <- (tail lista), (exponant x) == (exponant highestTerm)])
              ++ sortB [x | x <- lista, (exponant x) /= (exponant highestTerm)]
              where highestTerm = (head lista)

-- Sorts all the Expos of a monomial both by variable and exponent
sortFunction :: [Expo] -> [Expo]
sortFunction [] = []
sortFunction lista = sortB (sortByEx lista)

-- Applies the Expos final sorting function above to a whole term (monomial)
sortFunctionForTerm :: Term -> Term
sortFunctionForTerm t = Term (number t) (sortFunction (expos t))

-- Applies the above function to all the terms (whole string)
sortFunctionForAllTerms :: [Term] -> [Term]
sortFunctionForAllTerms [] = []
sortFunctionForAllTerms (x:xs) = (sortFunctionForTerm x):(sortFunctionForAllTerms xs)



--------------- Divide the given array in string parts ---------------

-- Devides the initial string (polynomial) in smaller ones (monomials) separating them by the '+' an '-' signals
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

-- Concatenates a list of lists into a list
myconcat :: [[a]] -> [a]
myconcat [] = []
myconcat (x:xs) = x ++ myconcat xs

takeExpoNum :: [Char] -> [Char]
takeExpoNum [x] = [x]
takeExpoNum (x:xs) = x:(takeExpoNum xs)

-- Transforms the variables and exponents of a monomial in various Expos
makeExpos :: [Char] -> [Expo]
makeExpos [] = []
makeExpos [x] = [Expo x 1]
makeExpos (x:xs)
  | ((isAlpha x) && length (dropWhile (/='*') (x:xs)) == 0) = [inExpo (takeWhile (/='*') (x:xs)) ]
  | (length (tail (dropWhile (/='*') (x:xs))) == 0) = []
  | otherwise = [inExpo (takeWhile (/='*') (x:xs)) ]++
                myconcat[makeExpos ( tail(dropWhile (/='*') (x:xs)))]

-- Transforms the variables and exponents of a monomial in a Expo
inExpo :: [Char] -> Expo
inExpo [] = Expo ' ' 0
inExpo [x] = Expo x 1
inExpo (x:y)
  | (isAlpha x) = if (head y == '^') then Expo x (read (takeExpoNum (tail y))::Integer) else Expo x 1
  | otherwise = inExpo y

-- Takes the coeficient of the monomials in string form
takeNum :: [Char] -> [Char]
takeNum [x] = [x]
takeNum x = takeWhile (/='*') x

-- Transforms monomials in the Term data type
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

-- Applies the above function to every monomial (whole string) to transform them in the data type 'Term'
allInTerm :: [[Char]] -> [Term]
allInTerm [] = []
allInTerm (x:xs) = [inTerm x]++(allInTerm xs)



------------------------------- Term to String ------------------------

-- Transforms all the Terms back to string to display on the result the whole string
allTermsToString :: [Term] -> [Char]
allTermsToString [] = []
allTermsToString [x] = termToString x
allTermsToString (x:xs)
  | ((number (head xs)) < 0) = termToString x ++ " " ++ allTermsToString xs
  | otherwise = termToString x ++ " + " ++ allTermsToString xs

-- Transforms Terms back to string to display on the result
termToString :: Term -> [Char]
termToString t
  | ((number t == 1) && ((head(expos t)) == (Expo (var (head(expos t))) 0)) && (expoToString(expos t) == [])) = "1"++expoToString(expos t)
  | ((number t == 1) && ((head(expos t)) == (Expo (var (head(expos t))) 0))) = "1"++"*"++expoToString(expos t)
  | (number t == 1) = expoToString(expos t)
  | (number t == -1) = "-"++expoToString(expos t)
  | ((head (expos t)) == Expo ' ' 0) = show(number t) ++ expoToString(expos t)
  | otherwise = show(number t)++"*"++expoToString(expos t)

-- Transforms Expos back to string to display on the result
expoToString :: [Expo] -> [Char]
expoToString [] = []
expoToString [x]
  | (x == Expo (var x) 1) = [var x]
  | (x == Expo ' ' 0) = []
  | otherwise = [var x]++"^"++show(exponant x)
expoToString (x:xs)
  | (expoToString xs == []) = (expoToString [x])++(expoToString xs)
  | otherwise = (expoToString [x])++"*"++(expoToString xs)
