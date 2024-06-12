module Pages.Articles.New exposing
    ( Props, decoder
    , Model, init, onPropsChanged
    , Msg, update, subscriptions
    , view
    )

{-|

@docs Props, decoder
@docs Model, init, onPropsChanged
@docs Msg, update, subscriptions
@docs view

-}

import Browser
import Components.Form
import Effect exposing (Effect)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Http
import Json.Decode
import Json.Encode
import Shared
import Url exposing (Url)



-- PROPS


type alias Props =
    {}


decoder : Json.Decode.Decoder Props
decoder =
    Json.Decode.succeed {}



-- MODEL


type alias Model =
    { title : String
    , body : String
    }


init : Shared.Model -> Url -> Props -> ( Model, Effect Msg )
init shared url props =
    ( { title = ""
      , body = ""
      }
    , Effect.none
    )


onPropsChanged : Shared.Model -> Url -> Props -> Model -> ( Model, Effect Msg )
onPropsChanged shared url props model =
    ( model, Effect.none )



-- UPDATE


type Msg
    = SubmittedForm
    | TitleChanged String
    | BodyChanged String
    | PostRequestResponded (Result Http.Error Props)


update : Shared.Model -> Url -> Props -> Msg -> Model -> ( Model, Effect Msg )
update shared url props msg model =
    case msg of
        TitleChanged value ->
            ( { model | title = value }
            , Effect.none
            )

        BodyChanged value ->
            ( { model | body = value }
            , Effect.none
            )

        SubmittedForm ->
            let
                form : Json.Encode.Value
                form =
                    Json.Encode.object
                        [ ( "title", Json.Encode.string model.title )
                        , ( "body", Json.Encode.string model.body )
                        ]
            in
            ( model
            , Effect.post
                { url = "/articles"
                , decoder = decoder
                , body = Http.jsonBody form
                , onResponse = PostRequestResponded
                }
            )

        PostRequestResponded (Ok newProps) ->
            ( model, Effect.none )

        PostRequestResponded (Err httpError) ->
            ( model, Effect.none )


subscriptions : Shared.Model -> Url -> Props -> Model -> Sub Msg
subscriptions shared url props model =
    Sub.none



-- VIEW


view : Shared.Model -> Url -> Props -> Model -> Browser.Document Msg
view shared url props model =
    { title = "New Article"
    , body =
        [ h1 [] [ text "New Article" ]
        , Components.Form.view
            { onSubmit = SubmittedForm
            , submitButtonLabel = "Create article"
            , fields =
                [ Components.Form.TextField
                    { label = "Title"
                    , value = model.title
                    , onInput = TitleChanged
                    , error = Nothing
                    }
                , Components.Form.TextArea
                    { label = "Body"
                    , value = model.body
                    , onInput = BodyChanged
                    , error = Nothing
                    }
                ]
            }
        ]
    }
