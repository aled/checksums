-----------------------------------------------------------------------------
--
-- Module      :  Rsync
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

module Rsync (
  weakChecksum,
  strongChecksum
) where

import qualified Data.ByteString as B (ByteString, foldl)
import Data.ByteString.Char8 (pack)
import Data.Word (Word8, Word32)
import Data.Bits (shiftL, shiftR, (.&.), (.|.))
import Data.Char (intToDigit)
import Crypto.Hash.MD4 (hash)

import Hex (word32ToHex, byteStringToHex)

-- |
-- prop> (weakChecksum $ pack "hello") == "062c0215"
-- prop> (weakChecksum $ pack "the quick brown fox jumps over the lazy dog.") == "71551028"
weakChecksum :: B.ByteString -> String
weakChecksum x = word32ToHex $ fromIntegral (B.foldl accumulate 1 x)

accumulate :: Word32 -> Word8 -> Word32
accumulate c x = do
  let a = c .&. 0xffff
  let b = (c `shiftR` 16) .&. 0xffff
  let a' = a + fromIntegral x
  let b' = b + a'
  b' `shiftL` 16 .|. a'

strongChecksum :: B.ByteString -> String
strongChecksum x = byteStringToHex $ hash x

