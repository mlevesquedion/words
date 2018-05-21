module Msg exposing (..)

import Http exposing (..)
import Json exposing (JsonResult)


type Msg
    = ChangePrefix String
    | ChangeSuffix String
    | NewWords (Result Http.Error JsonResult)
    | NextPage
    | PreviousPage
    | ResetPage
