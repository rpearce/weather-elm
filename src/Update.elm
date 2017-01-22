module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Commands exposing (..)
import Geocoding exposing (initialGeocodingResult)
import DarkSky


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateAddress text ->
            ( { model
                | address = text
                , weather = DarkSky.initialModel
              }
            , Cmd.none
            )

        SendAddress ->
            ( model, geocodeAddress model.address )

        GeocodeAddress address ->
            ( model, geocodeAddress address )

        ReceiveGeocoding (Ok resp) ->
            let
                result =
                    resp.results
                        |> List.head
                        |> Maybe.withDefault initialGeocodingResult

                location =
                    result.geometry.location

                newModel =
                    { model | coords = ( location.lat, location.lng ) }
            in
                ( newModel, fetchWeather newModel.coords )

        ReceiveGeocoding (Err _) ->
            ( model, Cmd.none )

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
