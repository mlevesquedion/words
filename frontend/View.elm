module View exposing (view)

import Msg exposing (Msg(..))
import Model exposing (Model)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : Model -> Html Msg
view model =
    div
        [ class "master" ]
        [ h1 []
            [ text "words" ]
        , div
            [ class "mainContent" ]
            [ prefixField model
            , renderWords model
            , suffixField model
            ]
        , renderPageBar model
        ]


prefixField : Model -> Html Msg
prefixField model =
    div [ class "field" ]
        [ p [] [ text "that start with ..." ]
        , input [ onInput ChangePrefix, value model.prefix ] []
        , button [ onClick (ChangePrefix "") ] [ text "Clear" ]
        ]


suffixField : Model -> Html Msg
suffixField model =
    div [ class "field" ]
        [ p [] [ text "and end with ..." ]
        , input [ onInput ChangeSuffix, value model.suffix ] []
        , button [ onClick (ChangeSuffix "") ] [ text "Clear" ]
        ]


renderPageBar : Model -> Html Msg
renderPageBar model =
    let
        isFirstPage =
            model.page == 1

        isLastPage =
            List.isEmpty model.words
    in
        div
            [ class "pageBar" ]
            [ button [ disabled isFirstPage, onClick PreviousPage ] [ text "<" ]
            , div [] [ text <| toString model.page ]
            , button [ disabled isLastPage, onClick NextPage ] [ text ">" ]
            , button [ onClick ResetPage ] [ text "Reset" ]
            ]


renderWords : Model -> Html Msg
renderWords model =
    if List.isEmpty model.words then
        p [ class "null" ] [ text "No words" ]
    else
        ul [] (List.map (makeListElement model.prefix model.suffix) model.words)


makeListElement : String -> String -> String -> Html Msg
makeListElement prefix suffix word =
    li [] [ renderWord prefix suffix word ]


renderWord : String -> String -> String -> Html Msg
renderWord prefix suffix word =
    if prefix == suffix && prefix == word then
        div [ class "word" ] [ span [ class "blue" ] [ text prefix ] ]
    else
        div [ class "word" ]
            [ span [ class "green" ] [ text prefix ]
            , span [] [ text (trimIxes prefix suffix word) ]
            , span [ class "red" ] [ text suffix ]
            ]


trimIxes : String -> String -> String -> String
trimIxes prefix suffix =
    let
        prefixLength =
            String.length prefix

        suffixLength =
            String.length suffix
    in
        String.dropLeft prefixLength << String.dropRight suffixLength
