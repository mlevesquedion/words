module Update exposing (..)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Requests exposing (fetchWords)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangePrefix newPrefix ->
            let
                newModel =
                    { model | prefix = newPrefix, page = 1 }
            in
                ( newModel, fetchWords newModel )

        ChangeSuffix newSuffix ->
            let
                newModel =
                    { model | suffix = newSuffix, page = 1 }
            in
                ( newModel, fetchWords newModel )

        PreviousPage ->
            let
                newModel =
                    { model | page = max (model.page - 1) 1 }
            in
                ( newModel, fetchWords newModel )

        NextPage ->
            let
                newModel =
                    { model | page = model.page + 1 }
            in
                ( newModel, fetchWords newModel )

        ResetPage ->
            let
                newModel =
                    { model | page = 1 }
            in
                ( newModel, fetchWords newModel )

        NewWords (Ok newWords) ->
            ( { model | words = newWords.result }, Cmd.none )

        NewWords (Err _) ->
            ( { model | words = [ "Error : could not retrieve words" ] }, Cmd.none )
