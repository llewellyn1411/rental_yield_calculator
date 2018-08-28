module Messages exposing (..)

import Models exposing (FormField)


type Msg
    = NoOp
    | Submit
    | SetField FormField String
