module Update exposing (..)

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
    if model.mortgage == 0 || model.interest == 0 || model.period == 0 || model.rent == 0 then
        model
    else
        let
            r =
                monthlyInterest model.interest

            mortgagePayments =
                monthlyRepayment model.mortgage r (toFloat model.period * 12)

            nYield =
                netYield mortgagePayments model.rent model.mortgage

            gYield =
                grossYield model.rent model.mortgage
        in
        { model | mortgagePayments = mortgagePayments, netYield = nYield, grossYield = gYield }


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


monthlyInterest : Float -> Float
monthlyInterest interest =
    (interest / 100) / 12


monthlyRepayment : Float -> Float -> Float -> Float
monthlyRepayment principal monthlyInterest numberOfPayments =
    let
        a =
            monthlyInterest * ((1 + monthlyInterest) ^ numberOfPayments)

        b =
            (1 + monthlyInterest) ^ numberOfPayments - 1
    in
    principal * (a / b)


netYield : Float -> Float -> Float -> Float
netYield mortgagePayments rent mortgage =
    let
        expenses =
            mortgagePayments * 12

        income =
            rent * 11
    in
    ((income - expenses) / mortgage) * 100


grossYield : Float -> Float -> Float
grossYield rent mortgage =
    ((rent * 11) / mortgage) * 100
