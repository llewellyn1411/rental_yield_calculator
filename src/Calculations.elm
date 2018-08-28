module Calculations exposing (..)

import Models exposing (..)


monthlyInterest : Interest -> MonthlyInterest
monthlyInterest interest =
    (interest / 100) / 12


monthlyRepayment : Mortgage -> MonthlyInterest -> MonthlyPeriod -> Payments
monthlyRepayment mortgage monthlyInterest numberOfPayments =
    let
        a =
            monthlyInterest * ((1 + monthlyInterest) ^ numberOfPayments)

        b =
            (1 + monthlyInterest) ^ numberOfPayments - 1
    in
    mortgage * (a / b)


netYield : Payments -> Rent -> Mortgage -> Float
netYield payments rent mortgage =
    let
        expenses =
            payments * 12

        income =
            rent * 11
    in
    ((income - expenses) / mortgage) * 100


grossYield : Rent -> Mortgage -> Float
grossYield rent mortgage =
    ((rent * 11) / mortgage) * 100
