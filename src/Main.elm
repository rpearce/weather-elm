module Main exposing (..)

import Html exposing (..)
import Models exposing (..)
import Messages exposing (..)
import Update exposing (..)
import View exposing (..)
import Commands exposing (..)


init : ( Model, Cmd Msg )
init =
    ( Models.initialModel, geocodeAddress initialModel.address )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- Main


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
