module DarkSky
    exposing
        ( Model
        , Coords
        , initialModel
        , fetchWeather
        )

import Http
import Json.Decode exposing (float, string, Decoder)
import Json.Decode.Pipeline exposing (decode, required)


-- Types


type alias Model =
    { currently : Currently
    }


type alias Currently =
    { icon : String
    , summary : String
    , temperature : Float
    }


type alias Coords =
    ( Float, Float )



-- Init


initialModel : Model
initialModel =
    { currently = initialCurrently
    }


initialCurrently : Currently
initialCurrently =
    { icon = "–"
    , summary = "–"
    , temperature = 0
    }



-- Http


weatherUrl : Coords -> String
weatherUrl ( lat, lng ) =
    "http://localhost:5050/darksky/"
        ++ (toString lat)
        ++ ","
        ++ (toString lng)



--fetchWeather : Result Http.Error Model -> msg -> Coords -> Cmd msg


fetchWeather toMessage coords =
    Http.get (weatherUrl coords) decodeWeather
        |> Http.send toMessage



-- Decoders


decodeWeather : Decoder Model
decodeWeather =
    decode Model
        |> required "currently" currentWeatherDecoder


currentWeatherDecoder : Decoder Currently
currentWeatherDecoder =
    decode Currently
        |> required "icon" string
        |> required "summary" string
        |> required "temperature" float
