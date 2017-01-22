module Models
    exposing
        ( Model
        , Coords
        , initialModel
        )

import DarkSky


type alias Model =
    { address : String
    , coords : Coords
    , weather : DarkSky.Model
    }


type alias Coords =
    ( Float, Float )


initialModel : Model
initialModel =
    { address = "Auckland, NZ"
    , coords = ( 0, 0 )
    , weather = DarkSky.initialModel
    }
