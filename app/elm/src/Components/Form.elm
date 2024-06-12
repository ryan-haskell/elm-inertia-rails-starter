module Components.Form exposing (Field(..), view)

import Html exposing (..)
import Html.Attributes as Attr
import Html.Events as Events exposing (onSubmit)


view :
    { fields : List (Field msg)
    , onSubmit : msg
    , submitButtonLabel : String
    }
    -> Html msg
view props =
    let
        children : List (Html msg)
        children =
            List.map viewField props.fields
                ++ [ viewSubmitButton props.submitButtonLabel ]
                |> List.intersperse (br [ Attr.style "margin" "1rem 0" ] [])
    in
    Html.form [ Events.onSubmit props.onSubmit ] children


type Field msg
    = TextField
        { label : String
        , value : String
        , onInput : String -> msg
        , error : Maybe String
        }
    | TextArea
        { label : String
        , value : String
        , onInput : String -> msg
        , error : Maybe String
        }


viewField : Field msg -> Html msg
viewField field =
    case field of
        TextField props ->
            label []
                [ strong [] [ text props.label ]
                , br [] []
                , input
                    [ Attr.type_ "text"
                    , Attr.value props.value
                    , Events.onInput props.onInput
                    ]
                    []
                , viewErrorIfPresent props.error
                ]

        TextArea props ->
            label []
                [ strong [] [ text props.label ]
                , br [] []
                , textarea
                    [ Attr.value props.value
                    , Events.onInput props.onInput
                    ]
                    []
                , viewErrorIfPresent props.error
                ]


viewSubmitButton : String -> Html msg
viewSubmitButton submitButtonLabel =
    button [ Attr.type_ "submit" ] [ text submitButtonLabel ]


viewErrorIfPresent : Maybe String -> Html msg
viewErrorIfPresent error =
    case error of
        Nothing ->
            text ""

        Just message ->
            p [ Attr.style "color" "red" ] [ text message ]
