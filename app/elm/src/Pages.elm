{- ✨ GENERATED by https://www.npmjs.com/package/elm-inertia ✨ -}


module Pages exposing (Model, Msg, init, onPropsChanged, subscriptions, update, view)

import Browser exposing (Document)
import Effect exposing (Effect)
import Html
import Inertia exposing (PageObject)
import Json.Decode exposing (Value)
import Pages.Articles.Index
import Pages.Error404
import Pages.Error500
import Shared
import Url exposing (Url)


type Model
    = Model_Articles_Index { props : Pages.Articles.Index.Props, model : Pages.Articles.Index.Model }
    | Model_Error404 { model : Pages.Error404.Model }
    | Model_Error500 { info : Pages.Error500.Info, model : Pages.Error500.Model }


type Msg
    = Msg_Articles_Index Pages.Articles.Index.Msg
    | Msg_Error404 Pages.Error404.Msg
    | Msg_Error500 Pages.Error500.Msg


init : Shared.Model -> Url -> PageObject Value -> ( Model, Effect Msg )
init shared url pageObject =
    case String.toLower pageObject.component of
        "articles/index" ->
            initForPage shared url pageObject <|
                { decoder = Pages.Articles.Index.decoder
                , init = Pages.Articles.Index.init
                , toModel = Model_Articles_Index
                , toMsg = Msg_Articles_Index
                }

        _ ->
            let
                ( pageModel, pageEffect ) =
                    Pages.Error404.init shared url
            in
            ( Model_Error404 { model = pageModel }
            , Effect.map Msg_Error404 pageEffect
            )


update : Shared.Model -> Url -> PageObject Value -> Msg -> Model -> ( Model, Effect Msg )
update shared url pageObject msg model =
    case ( msg, model ) of
        ( Msg_Articles_Index pageMsg, Model_Articles_Index page ) ->
            let
                ( pageModel, pageEffect ) =
                    Pages.Articles.Index.update shared url page.props pageMsg page.model
            in
            ( Model_Articles_Index { page | model = pageModel }
            , Effect.map Msg_Articles_Index pageEffect
            )

        ( Msg_Error404 pageMsg, Model_Error404 page ) ->
            let
                ( pageModel, pageEffect ) =
                    Pages.Error404.update shared url pageMsg page.model
            in
            ( Model_Error404 { page | model = pageModel }
            , Effect.map Msg_Error404 pageEffect
            )

        ( Msg_Error500 pageMsg, Model_Error500 page ) ->
            let
                ( pageModel, pageEffect ) =
                    Pages.Error500.update shared url page.info pageMsg page.model
            in
            ( Model_Error500 { page | model = pageModel }
            , Effect.map Msg_Error500 pageEffect
            )

        _ ->
            ( model, Effect.none )


subscriptions : Shared.Model -> Url -> PageObject Value -> Model -> Sub Msg
subscriptions shared url pageObject model =
    case model of
        Model_Articles_Index page ->
            Pages.Articles.Index.subscriptions shared url page.props page.model
                |> Sub.map Msg_Articles_Index

        Model_Error404 page ->
            Pages.Error404.subscriptions shared url page.model
                |> Sub.map Msg_Error404

        Model_Error500 page ->
            Pages.Error500.subscriptions shared url page.info page.model
                |> Sub.map Msg_Error500


view : Shared.Model -> Url -> PageObject Value -> Model -> Document Msg
view shared url pageObject model =
    case model of
        Model_Articles_Index page ->
            Pages.Articles.Index.view shared url page.props page.model
                |> mapDocument Msg_Articles_Index

        Model_Error404 page ->
            Pages.Error404.view shared url page.model
                |> mapDocument Msg_Error404

        Model_Error500 page ->
            Pages.Error500.view shared url page.info page.model
                |> mapDocument Msg_Error500


onPropsChanged :
    Shared.Model
    -> Url
    -> PageObject Value
    -> Model
    -> ( Model, Effect Msg )
onPropsChanged shared url pageObject model =
    case model of
        Model_Articles_Index page ->
            onPropsChangedForPage shared url pageObject page <|
                { decoder = Pages.Articles.Index.decoder
                , onPropsChanged = Pages.Articles.Index.onPropsChanged
                , toModel = Model_Articles_Index
                , toMsg = Msg_Articles_Index
                }

        Model_Error404 page ->
            ( model, Effect.none )

        Model_Error500 page ->
            ( model, Effect.none )



-- HELPERS


mapDocument : (a -> b) -> Browser.Document a -> Browser.Document b
mapDocument fn doc =
    { title = doc.title
    , body = List.map (Html.map fn) doc.body
    }


onPropsChangedForPage :
    Shared.Model
    -> Url
    -> PageObject Value
    -> { props : props, model : model }
    ->
        { decoder : Json.Decode.Decoder props
        , onPropsChanged : Shared.Model -> Url -> props -> model -> ( model, Effect msg )
        , toModel : { props : props, model : model } -> Model
        , toMsg : msg -> Msg
        }
    -> ( Model, Effect Msg )
onPropsChangedForPage shared url pageObject page options =
    case Json.Decode.decodeValue options.decoder pageObject.props of
        Ok props ->
            let
                ( pageModel, pageEffect ) =
                    options.onPropsChanged shared url props page.model
            in
            ( options.toModel { props = props, model = pageModel }
            , Effect.map options.toMsg pageEffect
            )

        Err jsonDecodeError ->
            let
                info : Pages.Error500.Info
                info =
                    { pageObject = pageObject, error = jsonDecodeError }

                ( pageModel, pageEffect ) =
                    Pages.Error500.init shared url info
            in
            ( Model_Error500 { info = info, model = pageModel }
            , Effect.map Msg_Error500 pageEffect
            )


initForPage :
    Shared.Model
    -> Url
    -> PageObject Value
    ->
        { decoder : Json.Decode.Decoder props
        , init : Shared.Model -> Url -> props -> ( model, Effect msg )
        , toModel : { props : props, model : model } -> Model
        , toMsg : msg -> Msg
        }
    -> ( Model, Effect Msg )
initForPage shared url pageObject options =
    case Json.Decode.decodeValue options.decoder pageObject.props of
        Ok props ->
            let
                ( pageModel, pageEffect ) =
                    options.init shared url props
            in
            ( options.toModel { props = props, model = pageModel }
            , Effect.map options.toMsg pageEffect
            )

        Err jsonDecodeError ->
            let
                info : Pages.Error500.Info
                info =
                    { pageObject = pageObject, error = jsonDecodeError }

                ( pageModel, pageEffect ) =
                    Pages.Error500.init shared url info
            in
            ( Model_Error500 { info = info, model = pageModel }
            , Effect.map Msg_Error500 pageEffect
            )