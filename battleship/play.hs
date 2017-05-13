import           Data.HashMap.Strict as HM


newtype Latitude = Latitude Int
newtype Longitude = Longitude Int
newtype XOffset = XOffset Int
newtype YOffset = YOffset Int

data Coord = Coord Latitude Longitude
data Offset = Offset XOffset YOffset

data ShipTemplate = ShipTemplate [Offset]
data Rotation = Rot0 | Rot90 | Rot180 | Rot270
data Ship = Ship (HM.HashMap Coord ShipStatus)
data ShipStatus = Damaged | Floating

data Response = Hit | Miss | HitAndSunk
data Pin = RedPin | WhitePin
data Board = Board (HM.HashMap Coord Pin)
newtype Reality = Reality [Ship]

data Player = Player Board Reality
newtype Attacker = Attacker Player
newtype Attacked = Attacked Player
newtype Attack = Attack Coord
data Turn = Turn Attacker Attacked Attack
data TurnResult = TurnResult Attacker Attacked


attack :: Turn -> TurnResult
attack = undefined
