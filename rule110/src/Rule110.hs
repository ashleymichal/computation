module Rule110 where


import qualified Data.Vector as Vector

someFunc :: IO ()
someFunc = putStrLn "someFunc"

data Digit = One | Zero

instance Show Digit where
    show One  = "1"
    show Zero = "0"

data Row = Row (Vector.Vector Digit)

nextDigit :: Digit -> Digit -> Digit -> Digit
nextDigit One  One  One  = Zero
nextDigit Zero Zero Zero = Zero
nextDigit One  Zero Zero = Zero
nextDigit _    _    _    = One

-- nextRow :: Row -> Row
