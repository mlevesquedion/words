module Model exposing (Model)


type alias Model =
    { prefix : String
    , suffix : String
    , words : List String
    , page : Int
    }
