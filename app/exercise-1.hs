import CodeWorld

main :: IO ()
main = exercise1

botCircle, topCircle :: Color -> Picture
botCircle c = colored c (translated 0 (-3) (solidCircle 1))
midCircle c = colored c (solidCircle 1)
topCircle c = colored c (translated 0   3  (solidCircle 1))
circlesFunc = [topCircle, midCircle, botCircle]

frame :: Picture
frame = rectangle 2.5 8.5

-- long green phase: 4 secs
-- short amber phase: 1 secs
-- long red phase: 3 secs
-- short red and amber phase: 1
{--
Define:
1. duration, top-color, mid-color, bot-color DS
2. function to turn system time into a trafficController that displays the colors
--}
durations = [4, 1, 3, 1]
colorSets = [
  [green, black, black],  -- green on
  [black, yellow, black], -- yellow on
  [black, black, red],    -- red on
  [black, yellow, red]]   -- red and yellow on

-- takes a list of colors, a list of circle functions, combine them into one picture
trafficLights :: [Color] -> [Color -> Picture] -> Picture
trafficLights [] [] = frame
trafficLights (c:restColors) (f:restCircles)
  -- render this circle with current color, recursively render the rest
  = f c & trafficLights restColors restCircles

-- abstract the calculation of what phase it is given the system time and the
-- phase ratio list
-- periodPhase :: Double -> [Num] -> Integer
-- periodPhase t phases
--   |

trafficController :: Double -> Picture
trafficController t
  | round t `mod` 9 < 4 = trafficLights (colorSets!!0) circlesFunc
  | round t `mod` 9 < 5 = trafficLights (colorSets!!1) circlesFunc
  | round t `mod` 9 < 8 = trafficLights (colorSets!!2) circlesFunc
  | otherwise = trafficLights (colorSets!!3) circlesFunc

trafficLightAnimation :: Double -> Picture
trafficLightAnimation = trafficController

exercise1 :: IO ()
exercise1 = animationOf trafficLightAnimation

-- Exercise 2

tree :: Integer -> Picture
tree 0 = blank
tree n = polyline [(0,0),(0,1)] & translated 0 1
  (rotated  (pi/10) (tree (n-1)) &
   rotated (-pi/10) (tree (n-1)))

exercise2 :: IO ()
exercise2 = undefined

