module Messages exposing (..)

import Http
import DarkSky


type Msg
    = FetchWeather DarkSky.Coords
    | ReceiveWeather (Result Http.Error DarkSky.Model)
    | NoOp
