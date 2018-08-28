module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (Msg)
import Models exposing (..)
import Round


view : Model -> Html Msg
view model =
    div []
        [ navView appName
        , div [ class "container" ]
            [ div
                [ class "row" ]
                [ formView model
                ]
            ]
        ]


navView : AppName -> Html Msg
navView appName =
    nav []
        [ div [ class "header" ]
            [ a [ class "brand-logo center", href "#" ]
                [ text appName ]
            ]
        ]


formView : Model -> Html Msg
formView model =
    div [ class "col s12" ]
        [ resultView model
        , fieldsView model
        , submitButton model
        ]


resultView : Model -> Html Msg
resultView model =
    if model.mortgagePayments == 0 then
        p [] [ text "Please fill in the form below" ]
    else
        let
            testx =
                Round.round 2 3.1456

            value =
                Round.round 2 model.mortgage

            interest =
                Round.round 2 model.interest

            repayments =
                Round.round 2 model.mortgagePayments

            netYield =
                Round.round 2 model.netYield

            grossYield =
                Round.round 2 model.grossYield

            result =
                "Based on a mortgage value of "
                    ++ value
                    ++ " with "
                    ++ interest
                    ++ "% interest your monthly repayments would be £"
                    ++ repayments
                    ++ ". This will result in a Gross Yield of "
                    ++ grossYield
                    ++ "% and a Net Yield of "
                    ++ netYield
                    ++ "%"
        in
        div []
            [ p [] [ text result ]
            ]


fieldsView : Model -> Html Msg
fieldsView model =
    div []
        [ div [ class "row" ]
            [ div [ class "input-field col s6" ]
                [ Html.input [ placeholder "Mortgage Value", type_ "number", id "mortgage_value", required True, value (toString model.mortgage), onInput <| Messages.SetField Mortgage ] []
                , label [ for "mortgage_value", class "active" ] [ text "Mortgage Value" ]
                ]
            , div [ class "input-field col s6" ]
                [ Html.input [ placeholder "Mortgage Interest", type_ "number", id "mortgage_interest", required True, value (toString model.interest), onInput <| Messages.SetField Interest ] []
                , label [ for "mortgage_interest", class "active" ] [ text "Mortgage Interest" ]
                ]
            ]
        , div [ class "row" ]
            [ div [ class "input-field col s6" ]
                [ Html.input [ placeholder "Mortgage Period", type_ "number", id "mortgage_period", required True, value (toString model.period), onInput <| Messages.SetField Period ] []
                , label [ for "mortgage_period", class "active" ] [ text "Mortgage Period" ]
                ]
            , div [ class "input-field col s6" ]
                [ Html.input [ placeholder "Rental Income", type_ "number", required True, id "rental_income", value (toString model.rent), onInput <| Messages.SetField Rent ] []
                , label [ for "rental_income", class "active" ] [ text "Rental Income" ]
                ]
            ]
        ]


inputView : String -> Float -> Html Msg
inputView name currentValue =
    div [ class "row" ]
        [ div [ class "input-field col s12" ]
            [ Html.input [ placeholder name, type_ "number", required True, value (toString currentValue) ] []
            ]
        ]


submitButton : Model -> Html Msg
submitButton model =
    button [ class "btn waves-effect waves-light pulse btn-large", onClick Messages.Submit ] [ text "SUBMIT" ]
