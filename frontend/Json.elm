module Json exposing (..)

import Json.Decode as Decode exposing (..)


type alias JsonResult =
    { result : List String
    }


decodeJson : Decode.Decoder JsonResult
decodeJson =
    Decode.map JsonResult
        (field "result" (Decode.list Decode.string))
