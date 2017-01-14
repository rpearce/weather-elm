module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }



-- Model


type alias Model =
    { city : City
    , days : List Day
    , input : String
    }


type alias City =
    { name : String
    , weather : String
    , temperature : Int
    }


type alias Day =
    { name : String
    , high : Int
    , low : Int
    }


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { city = initialCity
    , days = []
    , input = initialCity.name
    }


initialCity : City
initialCity =
    { name = "Charleston, SC"
    , weather = "Chance of meatballs"
    , temperature = 25
    }



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
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
                , small [ class "city__weather" ] [ text model.city.weather ]
                , div [ class "city__temp" ] [ text (toString model.city.temperature) ]
                ]
            , section [ class "section--days" ]
                [ ul [ class "days" ]
                    [ li [ class "day" ]
                        [ div [ class "day__name" ] [ text "Monday" ]
                        , div [ class "day__icon" ] [ text "sun" ]
                        , div [ class "day__temps" ]
                            [ div [ class "day__high" ] [ text (toString 70) ]
                            , div [ class "day__low" ] [ text (toString 62) ]
                            ]
                        ]
                    , li [ class "day" ]
                        [ div [ class "day__name" ] [ text "Monday" ]
                        , div [ class "day__icon" ] [ text "sun" ]
                        , div [ class "day__temps" ]
                            [ div [ class "day__high" ] [ text (toString 70) ]
                            , div [ class "day__low" ] [ text (toString 62) ]
                            ]
                        ]
                    , li [ class "day" ]
                        [ div [ class "day__name" ] [ text "Monday" ]
                        , div [ class "day__icon" ] [ text "sun" ]
                        , div [ class "day__temps" ]
                            [ div [ class "day__high" ] [ text (toString 70) ]
                            , div [ class "day__low" ] [ text (toString 62) ]
                            ]
                        ]
                    , li [ class "day" ]
                        [ div [ class "day__name" ] [ text "Monday" ]
                        , div [ class "day__icon" ] [ text "sun" ]
                        , div [ class "day__temps" ]
                            [ div [ class "day__high" ] [ text (toString 70) ]
                            , div [ class "day__low" ] [ text (toString 62) ]
                            ]
                        ]
                    , li [ class "day" ]
                        [ div [ class "day__name" ] [ text "Monday" ]
                        , div [ class "day__icon" ] [ text "sun" ]
                        , div [ class "day__temps" ]
                            [ div [ class "day__high" ] [ text (toString 70) ]
                            , div [ class "day__low" ] [ text (toString 62) ]
                            ]
                        ]
                    , li [ class "day" ]
                        [ div [ class "day__name" ] [ text "Monday" ]
                        , div [ class "day__icon" ] [ text "sun" ]
                        , div [ class "day__temps" ]
                            [ div [ class "day__high" ] [ text (toString 70) ]
                            , div [ class "day__low" ] [ text (toString 62) ]
                            ]
                        ]
                    , li [ class "day" ]
                        [ div [ class "day__name" ] [ text "Monday" ]
                        , div [ class "day__icon" ] [ text "sun" ]
                        , div [ class "day__temps" ]
                            [ div [ class "day__high" ] [ text (toString 70) ]
                            , div [ class "day__low" ] [ text (toString 62) ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


role : String -> Attribute msg
role str =
    attribute "role" str
