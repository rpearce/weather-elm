module Messages exposing (..)

import Http
import Models exposing (Coords)
import DarkSky
import Geocoding


type Msg
    = UpdateAddress String
    | SendAddress
    | GeocodeAddress String
    | ReceiveGeocoding (Result Http.Error Geocoding.Model)
    | FetchWeather Coords
    | ReceiveWeather (Result Http.Error DarkSky.Model)
    | NoOp
