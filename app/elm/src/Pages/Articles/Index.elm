module Pages.Articles.Index exposing
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
import Json.Decode
import Shared
import Url exposing (Url)



-- PROPS


type alias Props =
    { articles : List Article
    }


type alias Article =
    { id : Int
    , title : String
    }


decoder : Json.Decode.Decoder Props
decoder =
    Json.Decode.map Props
        (Json.Decode.field "articles" (Json.Decode.list articleDecoder))


articleDecoder : Json.Decode.Decoder Article
articleDecoder =
    Json.Decode.map2 Article
        (Json.Decode.field "id" Json.Decode.int)
        (Json.Decode.field "title" Json.Decode.string)



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
    = NoOp


update : Shared.Model -> Url -> Props -> Msg -> Model -> ( Model, Effect Msg )
update shared url props msg model =
    case msg of
        NoOp ->
            ( model, Effect.none )


subscriptions : Shared.Model -> Url -> Props -> Model -> Sub Msg
subscriptions shared url props model =
    Sub.none



-- VIEW


view : Shared.Model -> Url -> Props -> Model -> Browser.Document Msg
view shared url props model =
    { title = "Articles"
    , body =
        [ h1 [] [ text "Articles" ]
        , ul [] (List.map viewArticleLink props.articles)
        , p [] [ a [ href "/articles/new" ] [ text "Create article" ] ]
        ]
    }


viewArticleLink : Article -> Html Msg
viewArticleLink article =
    let
        url : String
        url =
            "/articles/" ++ String.fromInt article.id
    in
    li []
        [ a [ href url ] [ text article.title ]
        ]
