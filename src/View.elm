module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, placeholder, type_, value)
import Html.Events exposing (onInput, onSubmit)
import Models exposing (Model)
import Messages exposing (Msg(..))


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ main_ [ attribute "role" "main", class "main" ]
            [ header [ role "header", class "city" ]
                [ form [ onSubmit SendAddress ]
                    [ input
                        [ type_ "text"
                        , class "city__nameInput"
                        , placeholder "City"
                        , value model.address
                        , onInput UpdateAddress
                        ]
                        []
                    ]
                , small [ class "city__weather" ] [ text model.weather.currently.summary ]
                , div [ class "city__temp" ] [ text (toString (round model.weather.currently.temperature)) ]
                ]
            ]
        ]


role : String -> Attribute msg
role str =
    attribute "role" str
