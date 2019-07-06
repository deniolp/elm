import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)



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
  | Valid


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Age age ->
      { model | age = age }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Valid ->
      { model | valid = True }




-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewInput "text" "Age" model.age Age
    , viewButton "button" "Submit" Valid
    , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewButton : String -> String  -> msg -> Html msg
viewButton t p toMsg =
  button [ type_ t, onClick toMsg ] [ text p ]

viewValidation : Model -> Html msg
viewValidation model =
  if model.valid then
    if model.password == model.passwordAgain && String.length model.password > 4 && String.any Char.isDigit model.password && String.any Char.isUpper model.password && String.any Char.isLower model.password && String.length model.age > 0 && String.all Char.isDigit model.age then
      div [ style "color" "green" ] [ text "OK" ]
    else
    div [ style "color" "red" ] [ text "Passwords do not match!" ]
  else div [] []