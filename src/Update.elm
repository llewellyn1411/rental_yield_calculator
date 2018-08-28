module Update exposing (..)

import Calculations exposing (..)
import Messages exposing (Msg)
import Models exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Messages.NoOp ->
            ( model, Cmd.none )

        Messages.SetField field value ->
            ( setField field value model, Cmd.none )

        Messages.Submit ->
            ( submitForm model, Cmd.none )


submitForm : Model -> Model
submitForm model =
    if model.mortgage == 0 || model.interest == 1 || model.period == 0 || model.rent == 0 then
        model
    else
        let
            r =
                Calculations.monthlyInterest model.interest

            mortgagePayments =
                Calculations.monthlyRepayment model.mortgage r (toFloat model.period * 12)

            nYield =
                Calculations.netYield mortgagePayments model.rent model.mortgage

            gYield =
                Calculations.grossYield model.rent model.mortgage
        in
        { model | payments = mortgagePayments, netYield = nYield, grossYield = gYield }


setField : FormField -> String -> Model -> Model
setField field value model =
    case field of
        Mortgage ->
            { model | mortgage = String.toFloat value |> Result.withDefault 0 }

        Interest ->
            { model | interest = String.toFloat value |> Result.withDefault 0 }

        Period ->
            { model | period = String.toInt value |> Result.withDefault 0 }

        Rent ->
            { model | rent = String.toFloat value |> Result.withDefault 0 }
