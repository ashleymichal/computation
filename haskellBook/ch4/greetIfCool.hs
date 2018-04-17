module GreetIfCool where

greetIfCool :: String -> IO ()
greetIfCool coolness =
    if cool
        then putStrLn "eyyy"
    else
        putStrLn "pshhh"
    where cool =
            coolness == "frosty"
