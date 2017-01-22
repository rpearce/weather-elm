module Commands
    exposing
        ( fetchWeather
        , geocodeAddress
        )

import Models exposing (Coords)
import Messages exposing (..)
import DarkSky
import Geocoding


geocodeAddress : String -> Cmd Msg
geocodeAddress address =
    Geocoding.sendAddress ReceiveGeocoding address


fetchWeather : Coords -> Cmd Msg
fetchWeather coords =
    DarkSky.fetchWeather ReceiveWeather coords
