module Main exposing (Model, Msg(..), init, main, update, view, viewButton, viewInput, viewValidation)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    , valid : Bool
    }


init : Model
init =
    Model "" "" "" "" False



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Validate


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name, valid = False }

        Age age ->
            { model | age = age, valid = False }

        Password password ->
            { model | password = password, valid = False }

        PasswordAgain password ->
            { model | passwordAgain = password, valid = False }

        Validate ->
            { model | valid = True }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewInput "text" "Age" model.age Age
        , viewButton "button" "Submit" Validate
        , viewValidation model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewButton : String -> String -> msg -> Html msg
viewButton t p toMsg =
    button [ type_ t, onClick toMsg ] [ text p ]


viewValidation : Model -> Html msg
viewValidation model =
    if model.valid then
        if model.password == model.passwordAgain && String.length model.password > 4 && String.any Char.isDigit model.password && String.any Char.isUpper model.password && String.any Char.isLower model.password && Maybe.withDefault 0 (String.toInt model.age) > 0 && String.all Char.isDigit model.age then
            div [ style "color" "green" ] [ text "OK" ]

        else if Maybe.withDefault 0 (String.toInt model.age) < 1 || not (String.all Char.isDigit model.age) then
            div [ style "color" "red" ] [ text "Age is not correct!" ]

        else
            div [ style "color" "red" ] [ text "Passwords not correct or do not match!" ]

    else
        div [] []
