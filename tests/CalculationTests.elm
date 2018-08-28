module CalculationTests exposing (..)

import Calculations exposing (..)
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Round
import Test exposing (..)


suite : Test
suite =
    describe "Calculations"
        [ test "monthlyInterest is correctly calculated" <| \_ -> monthlyInterest 6 |> Expect.equal 0.005
        , test "monthlyRepayment is correctly calculated" <| \_ -> monthlyRepayment 180000 0.0016 300 |> Round.round 2 |> Expect.equal "755.95"
        , test "grossYield is correctly calculated" <| \_ -> grossYield 900 180000 |> Round.round 2 |> Expect.equal "5.50"
        , test "netYield is correctly calculated" <| \_ -> netYield 755.95 900 180000 |> Round.round 2 |> Expect.equal "0.46"
        ]
