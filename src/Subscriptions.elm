module Subscriptions exposing (..)

import Messages exposing (Msg)
import Models exposing (Model)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
