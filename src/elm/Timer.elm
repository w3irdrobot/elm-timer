module Main exposing (..)

import Html exposing (Html, span, text)
import Html.Attributes exposing (class)
import Html.App exposing (programWithFlags)
import String exposing (padLeft)
import List exposing (map)
import Time exposing (Time, every)
import Regex exposing (Regex, HowMany(All), regex, replace)


main =
    programWithFlags
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


second : Int
second =
    1


minute : Int
minute =
    60 * second


hour : Int
hour =
    60 * minute


day : Int
day =
    24 * hour


divMod : Int -> Int -> ( Int, Int )
divMod dividend divisor =
    ( dividend // divisor, dividend % divisor )


type alias Model =
    { seconds : Int
    , hoursThreshold : Int
    , formatUnderThreshold : String
    , formatOverThreshold : String
    }


init : Model -> ( Model, Cmd Msg )
init flags =
    ( flags, Cmd.none )


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( { model | seconds = model.seconds - 1 }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions { seconds } =
    if seconds == 0 then
        Sub.none
    else
        every Time.second Tick


view : Model -> Html Msg
view { seconds, hoursThreshold, formatUnderThreshold, formatOverThreshold } =
    let
        hours =
            seconds // hour

        days =
            seconds // day
    in
        if seconds == 0 then
            span [ class "timer" ] [ text "This promotion has ended." ]
        else if hours >= hoursThreshold then
            span [ class "timer" ] [ text (replaceInFormat "{D}" days 1 formatOverThreshold) ]
        else
            span [ class "timer" ] [ text (timerView seconds formatUnderThreshold) ]


timerView : Int -> String -> String
timerView rawSeconds format =
    let
        ( hours, remainingSecs ) =
            divMod rawSeconds hour

        ( minutes, seconds ) =
            divMod remainingSecs minute
    in
        format
            |> replaceInFormat "{H}" hours 2
            |> replaceInFormat "{M}" minutes 2
            |> replaceInFormat "{S}" seconds 2


replaceInFormat : String -> Int -> Int -> String -> String
replaceInFormat reg num padLength format =
    replace All (regex reg) (\_ -> stringifyAndPad padLength num) format


stringifyAndPad : Int -> Int -> String
stringifyAndPad padLength num =
    padLeft padLength '0' (toString num)
