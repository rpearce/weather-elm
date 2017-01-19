module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Commands exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchWeather coords ->
            ( model, fetchWeather coords )

        ReceiveWeather (Ok resp) ->
            let
                weather =
                    model.weather

                newWeather =
                    { weather | currently = resp.currently }
            in
                ( { model | weather = newWeather }
                , Cmd.none
                )

        ReceiveWeather (Err _) ->
            ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )
