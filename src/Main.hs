-----------------------------------------------------------------------------
--
-- Module      :  Main
-- Copyright   :
-- License     :  AllRightsReserved
--
-- Maintainer  :
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Main (
    main
) where

import Adler32 (adler32)
import Rsync (weakChecksum, strongChecksum)
import Data.ByteString.Char8 (pack)
import qualified Data.ByteString.Char8 as B (readFile)

main :: IO ()
main = do
  --input <- B.readFile "input.txt"
  --putStrLn $ adler32 input

  putStrLn $ adler32 $ pack "hello"  -- should be 062c0215
  putStrLn $ adler32 $ pack "the quick brown fox jumps over the lazy dog."  -- should be 71641028

  putStrLn $ weakChecksum $ pack "hello"  -- should be 062c0215
  putStrLn $ weakChecksum $ pack "the quick brown fox jumps over the lazy dog."  -- should be 71551028

  putStrLn $ strongChecksum $ pack "hello"  -- should be 866437cb7a794bce2b727acc0362ee27
  putStrLn $ strongChecksum $ pack "the quick brown fox jumps over the lazy dog."  -- should be d4e521ee8d0b221e05689cd55f3b528b


