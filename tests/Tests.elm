module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Timer exposing (..)
import Time


all : Test
all =
    describe "Timer"
        [ test "divMod" <|
            \() ->
                Expect.equal ( 1, 4 ) (divMod 9 5)
        , describe "update"
            [ test "Tick subtracts from model" <|
                \() ->
                    let
                        model =
                            Timer.Model 10 24 "{H}:{M}:{S}" "Starts in {D} days"

                        expectedModel =
                            Timer.Model 9 24 "{H}:{M}:{S}" "Starts in {D} days"
                    in
                        Expect.equal ( expectedModel, Cmd.none ) (Timer.update (Timer.Tick Time.second) model)
            , test "0 seconds returns a command on the port" <|
                \() ->
                    let
                        expectedCommand =
                            timerExpired "stop"

                        model =
                            Timer.Model 1 24 "{H}:{M}:{S}" "Starts in {D} days"

                        expectedModel =
                            Timer.Model 0 24 "{H}:{M}:{S}" "Starts in {D} days"
                    in
                        Expect.equal ( expectedModel, expectedCommand ) (Timer.update (Timer.Tick Time.second) model)
            ]
        ]
