module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, placeholder, type_, value)
import Html.Events exposing (onInput)
import Http
import Json.Decode exposing (float, string, Decoder)
import Json.Decode.Pipeline exposing (decode, required)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }



-- Model


type alias Model =
    { currentCity : String
    , currentWeather : CurrentWeather
    , days : List Day
    , input : String
    }


type alias Day =
    { name : String
    , high : Int
    , low : Int
    }


type alias Coords =
    ( Float, Float )


type alias WeatherResult =
    { currently : CurrentWeather
    }


type alias CurrentWeather =
    { icon : String
    , summary : String
    , temperature : Float
    }


type Msg
    = FetchWeather
    | ReceiveWeather (Result Http.Error WeatherResult)
    | NoOp


init : ( Model, Cmd Msg )
init =
    ( initialModel, fetchWeather ( 32.784618, -79.940918 ) )


initialModel : Model
initialModel =
    { currentCity = "Charleston, SC"
    , currentWeather = initialCurrentWeather
    , days = [ initialDay, initialDay, initialDay, initialDay, initialDay ]
    , input = "Charleston, SC"
    }


initialCurrentWeather : CurrentWeather
initialCurrentWeather =
    { icon = "–"
    , summary = "–"
    , temperature = 0
    }


initialDay : Day
initialDay =
    { name = "–"
    , high = 0
    , low = 0
    }


weatherUrl : Coords -> String
weatherUrl ( lat, lng ) =
    "http://localhost:9091/test.json"


fetchWeather : Coords -> Cmd Msg
fetchWeather coords =
    Http.get (weatherUrl coords) decodeWeather
        |> Http.send ReceiveWeather


decodeWeather : Decoder WeatherResult
decodeWeather =
    decode WeatherResult
        |> required "currently" currentWeatherDecoder


currentWeatherDecoder : Decoder CurrentWeather
currentWeatherDecoder =
    decode CurrentWeather
        |> required "icon" string
        |> required "summary" string
        |> required "temperature" float



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveWeather (Ok resp) ->
            ( { model | currentWeather = resp.currently }
            , Cmd.none
            )

        ReceiveWeather (Err _) ->
            ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- View


view : Model -> Html msg
view model =
    div [ class "container" ]
        [ main_ [ attribute "role" "main", class "main" ]
            [ header [ role "header", class "city" ]
                [ input
                    [ type_ "text"
                    , class "city__nameInput"
                    , placeholder "City"
                    , value model.input
                    ]
                    []
                , small [ class "city__weather" ] [ text model.currentWeather.summary ]
                , div [ class "city__temp" ] [ text (toString (round model.currentWeather.temperature)) ]
                ]
            , section [ class "section--days" ]
                [ ul [ class "days" ]
                    (List.map dayView model.days)
                ]
            ]
        ]


dayView : Day -> Html msg
dayView day =
    li [ class "day" ]
        [ div [ class "day__name" ] [ text "–" ]
        , div [ class "day__icon" ] [ text "–" ]
        , div [ class "day__temps" ]
            [ div [ class "day__high" ] [ text (toString 0) ]
            , div [ class "day__low" ] [ text (toString 0) ]
            ]
        ]


role : String -> Attribute msg
role str =
    attribute "role" str
