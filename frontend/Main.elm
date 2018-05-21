module Main exposing (..)

import Model exposing (Model)
import View exposing (view)
import Update exposing (update)
import Msg exposing (Msg)
import Html exposing (..)
import Requests exposing (fetchWords)


init : ( Model, Cmd Msg )
init =
    let
        model =
            Model "" "" [] 1
    in
        ( model, fetchWords model )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = (always Sub.none)
        }
