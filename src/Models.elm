module Models exposing (..)


type alias AppName =
    String


type alias Mortgage =
    Float


type alias Interest =
    Float


type alias Period =
    Int


type alias Rent =
    Float


type alias Payments =
    Float


type alias NetYield =
    Float


type alias GrossYield =
    Float


type alias MonthlyInterest =
    Float


type alias MonthlyPeriod =
    Float


type alias Model =
    { mortgage : Mortgage
    , interest : Interest
    , period : Period
    , rent : Rent
    , payments : Payments
    , netYield : NetYield
    , grossYield : GrossYield
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
