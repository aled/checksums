-----------------------------------------------------------------------------
--
-- Module      :  Adler32
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

module Adler32 (
  adler32
) where

import qualified Data.ByteString as B (ByteString, foldl)
import Data.Word (Word8, Word16, Word32)
import Data.ByteString.Char8 (pack)
import Data.Bits (shiftL, shiftR, (.&.), (.|.))

import Hex (word32ToHex)

-- |
-- prop> (adler32 $ pack "hello") == "062c0215"
-- prop> (adler32 $ pack "the quick brown fox jumps over the lazy dog.") == "71641028"
adler32 :: B.ByteString -> String
adler32 buf = do
  let c = B.foldl accumulate 1 buf
  word32ToHex $ fromIntegral c

accumulate :: Word32 -> Word8 -> Word32
accumulate c x = do
  let m = 65521
  let a = c .&. 0xffff
  let b = shiftR c 16 .&. 0xffff
  let a' = (a + fromIntegral x) `mod` m
  let b' = (b + a') `mod` m
  shiftL b' 16 .|. a'

