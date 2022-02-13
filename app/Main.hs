{-# OPTIONS_GHC -fno-warn-warnings-deprecations -fno-warn-unused-binds #-}
module Main where

import CodeWorld

ourPicture :: Picture
ourPicture = solidCircle 1

main :: IO ()
main = drawingOf ourPicture
