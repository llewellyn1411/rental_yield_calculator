module Models exposing (..)


type alias AppName =
    String


type alias Model =
    { mortgage : Float
    , interest : Float
    , period : Int
    , rent : Float
    , mortgagePayments : Float
    , netYield : Float
    , grossYield : Float
    }


type FormField
    = Mortgage
    | Interest
    | Period
    | Rent


initialModel : Model
initialModel =
    Model 0 0 0 0 0 0 0


appName : AppName
appName =
    "Rental Yield Calculator"
