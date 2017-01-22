module Geocoding
    exposing
        ( Model
        , sendAddress
        , initialGeocodingResult
        )

import Http
import Json.Decode exposing (float, list, string, Decoder)
import Json.Decode.Pipeline exposing (decode, required)


-- Models


type alias Model =
    { status : String
    , results : List GeocodingResult
    }


type alias GeocodingResult =
    { geometry : Geometry }


type alias Geometry =
    { location : Location }


type alias Location =
    { lat : Float
    , lng : Float
    }


initialGeocodingResult : GeocodingResult
initialGeocodingResult =
    { geometry =
        { location =
            { lat = 0
            , lng = 0
            }
        }
    }


geocodingUrl : String -> String
geocodingUrl address =
    "https://maps.googleapis.com/maps/api/geocode/json?address="
        ++ address
        ++ "&key=AIzaSyAoOtzqsBtVZrUq7H-lzeQuXhrYQMBmszw"


sendAddress : (Result Http.Error Model -> msg) -> String -> Cmd msg
sendAddress toMessage address =
    Http.get (geocodingUrl address) decodeGeocoding
        |> Http.send toMessage



-- Decoders


decodeGeocoding : Decoder Model
decodeGeocoding =
    decode Model
        |> required "status" string
        |> required "results" (list decodeGeocodingResult)


decodeGeocodingResult : Decoder GeocodingResult
decodeGeocodingResult =
    decode GeocodingResult
        |> required "geometry" decodeGeometry


decodeGeometry : Decoder Geometry
decodeGeometry =
    decode Geometry
        |> required "location" decodeLocation


decodeLocation : Decoder Location
decodeLocation =
    decode Location
        |> required "lat" float
        |> required "lng" float
