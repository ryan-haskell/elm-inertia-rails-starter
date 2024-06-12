module Pages.Articles.Edit exposing
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
import Url.Builder



-- PROPS


type alias Props =
    { article : Article
    }


decoder : Json.Decode.Decoder Props
decoder =
    Json.Decode.map Props
        (Json.Decode.field "article" articleDecoder)


type alias Article =
    { id : Int
    , title : String
    , body : String
    }


articleDecoder : Json.Decode.Decoder Article
articleDecoder =
    Json.Decode.map3 Article
        (Json.Decode.field "id" Json.Decode.int)
        (Json.Decode.field "title" Json.Decode.string)
        (Json.Decode.field "body" Json.Decode.string)



-- MODEL


type alias Model =
    { title : String
    , body : String
    }


init : Shared.Model -> Url -> Props -> ( Model, Effect Msg )
init shared url props =
    ( { title = props.article.title
      , body = props.article.body
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
            , Effect.patch
                { url =
                    Url.Builder.absolute
                        [ "articles", String.fromInt props.article.id ]
                        []
                , decoder = decoder
                , body = Http.jsonBody form
                , onResponse = PostRequestResponded
                }
            )

        PostRequestResponded (Ok newProps) ->
            ( model, Effect.none )

        PostRequestResponded (Err httpError) ->
            ( model, Effect.none )

        TitleChanged value ->
            ( { model | title = value }
            , Effect.none
            )

        BodyChanged value ->
            ( { model | body = value }
            , Effect.none
            )


subscriptions : Shared.Model -> Url -> Props -> Model -> Sub Msg
subscriptions shared url props model =
    Sub.none



-- VIEW


view : Shared.Model -> Url -> Props -> Model -> Browser.Document Msg
view shared url props model =
    { title = "Articles.Edit"
    , body =
        [ h1 [] [ text "Edit Article" ]
        , Components.Form.view
            { onSubmit = SubmittedForm
            , submitButtonLabel = "Update article"
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
