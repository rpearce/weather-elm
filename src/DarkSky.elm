module DarkSky
    exposing
        ( Model
        , initialModel
        , fetchWeather
        )

import Http
import Json.Decode exposing (float, string, Decoder)
import Json.Decode.Pipeline exposing (decode, required)


-- Models


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



-- Commands


weatherUrl : Coords -> String
weatherUrl ( lat, lng ) =
    "http://localhost:5050/forecast/"
        ++ (toString lat)
        ++ ","
        ++ (toString lng)


fetchWeather : (Result Http.Error Model -> msg) -> Coords -> Cmd msg
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
