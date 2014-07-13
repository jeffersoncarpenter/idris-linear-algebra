module Matrix

import Data.Floats

%access public

Matrix : Nat -> Nat -> Type -> Type
Matrix cols rows a = Vect rows (Vect cols a)


-- some Vect methods
dotProduct : (Num a) => Vect (S n) a -> Vect (S n) a -> a
dotProduct a b = foldr1 (+) $ zipWith (*) a b

crossProduct : (Num a) => Vect 3 a -> Vect 3 a -> Vect 3 a
crossProduct [a1, a2, a3] [b1, b2, b3] = [a2*b3 - a3*b2, a3*b1 - a1*b3, a1*b2 - b1*a2]

crossProduct2 : (Num a) => Vect 2 a -> Vect 2 a -> a
crossProduct2 a b = head $ crossProduct (0::a) (0::b)


-- some Vect Float methods
magnitude : Vect (S n) Float -> Float
magnitude v = sqrt $ dotProduct v v

distance : Vect (S n) Float -> Vect (S n) Float -> Float
distance a b = magnitude [| Classes.(-) a b |]


-- multiplies a matrix by a vector
multMatVect : (Num a) => Matrix (S m) (S n) a -> Vect (S m) a -> Vect (S n) a
multMatVect vs v = map (dotProduct v) vs


-- multiplies a matrix by a matrix
multMatMat : (Num a) => Matrix (S m) (S n) a -> Matrix (S n) (S o) a -> Matrix (S m) (S o) a
multMatMat a b = map (multMatVect (transpose a)) b


-- n-by-n identity matrix
identityMatrix : (Num a) => Matrix n n a
identityMatrix {n = Z}   = []
identityMatrix {n = S m} = (one :: replicate m zero) :: (map (zero ::) identityMatrix) where
  zero = fromInteger 0
  one  = fromInteger 1
