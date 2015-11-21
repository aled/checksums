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

import Test.DocTest

main :: IO()

main = do
    doctest ["-isrc", "src/Adler32.hs"]
    --doctest ["-isrc", "src/Rsync.hs"]


