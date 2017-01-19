module Commands exposing (fetchWeather)

import Messages exposing (..)
import DarkSky


fetchWeather : DarkSky.Coords -> Cmd Msg
fetchWeather coords =
    DarkSky.fetchWeather ReceiveWeather coords
