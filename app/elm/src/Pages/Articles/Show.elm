module Pages.Articles.Show exposing
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
import Effect exposing (Effect)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events
import Http
import Json.Decode
import Shared
import Url exposing (Url)
import Url.Builder



-- PROPS


type alias Props =
    { article : Article
    , editUrl : String
    }


decoder : Json.Decode.Decoder Props
decoder =
    Json.Decode.map2 Props
        (Json.Decode.field "article" articleDecoder)
        (Json.Decode.field "editUrl" Json.Decode.string)


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
    {}


init : Shared.Model -> Url -> Props -> ( Model, Effect Msg )
init shared url props =
    ( {}
    , Effect.none
    )


onPropsChanged : Shared.Model -> Url -> Props -> Model -> ( Model, Effect Msg )
onPropsChanged shared url props model =
    ( model, Effect.none )



-- UPDATE


type Msg
    = ClickedDelete
    | DeletedArticle (Result Http.Error ())


update : Shared.Model -> Url -> Props -> Msg -> Model -> ( Model, Effect Msg )
update shared url props msg model =
    case msg of
        ClickedDelete ->
            ( model
            , Effect.delete
                { url =
                    Url.Builder.absolute
                        [ "articles"
                        , String.fromInt props.article.id
                        ]
                        []
                , decoder = Json.Decode.succeed ()
                , onResponse = DeletedArticle
                }
            )

        DeletedArticle (Ok ()) ->
            ( model, Effect.none )

        DeletedArticle (Err httpError) ->
            ( model, Effect.none )


subscriptions : Shared.Model -> Url -> Props -> Model -> Sub Msg
subscriptions shared url props model =
    Sub.none



-- VIEW


view : Shared.Model -> Url -> Props -> Model -> Browser.Document Msg
view shared url { article, editUrl } model =
    { title = "Articles.Show"
    , body =
        [ p [] [ a [ href "/articles" ] [ text "Back" ] ]
        , h1 [] [ text article.title ]
        , p [] [ text article.body ]
        , p [] [ a [ href editUrl ] [ text "Edit" ] ]
        , p [] [ button [ Html.Events.onClick ClickedDelete ] [ text "Delete" ] ]
        ]
    }
