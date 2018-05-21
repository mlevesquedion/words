module Requests exposing (..)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Http exposing (..)
import Json exposing (JsonResult, decodeJson)


fetchWords : Model -> Cmd Msg
fetchWords model =
    let
        url =
            buildUrl model

        request =
            Http.get url decodeJson
    in
        Http.send NewWords request


buildUrl : Model -> String
buildUrl model =
    let
        pref =
            model.prefix

        suff =
            model.suffix

        page =
            model.page
    in
        "http://localhost:5000/words?prefix=" ++ pref ++ "&suffix=" ++ suff ++ "&page=" ++ (toString page)
