-----------------------------------------------------------------------------
--
-- Module      :  Hex
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

module Hex (
  word32ToHex,
  byteStringToHex
) where

import qualified Data.ByteString as B (ByteString, foldl, pack)
import Data.Word (Word8, Word32)
import Data.Char (intToDigit)
import Data.Bits (shiftR, (.&.))

toWord8 x = fromIntegral x :: Word8
toInt x = fromIntegral x :: Int

word32ToHex :: Word32 -> String
word32ToHex x = byteStringToHex $ B.pack $ map (extractWord8 x) [24, 16, 8, 0]
  where extractWord8 x shiftBy = toWord8 (x `shiftR` shiftBy)

byteStringToHex :: B.ByteString -> String
byteStringToHex xs = reverse $ B.foldl prependHex "" xs
  where prependHex s x = lowerNybble x : upperNybble x : s
        upperNybble x = intToDigit $ toInt x `shiftR` 4
        lowerNybble x = intToDigit $ toInt x .&. 0xf

