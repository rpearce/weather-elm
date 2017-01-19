module Models exposing (..)

import DarkSky


type alias Model =
    { input : String
    , weather : DarkSky.Model
    }


initialModel : Model
initialModel =
    { input = "Charleston, SC"
    , weather = DarkSky.initialModel
    }
