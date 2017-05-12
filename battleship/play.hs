import           Data.HashMap.Strict as HM


newtype Latitude = Latitude Int
newtype Longitude = Longitude Int
data Coord = Coord { _latitude :: Latitude, _longitude :: Longitude }

newtype Ship = Ship (HM.HashMap Coord ShipStatus)
data ShipStatus = Damaged | Floating

data Response = Hit | Miss | HitAndSunk
