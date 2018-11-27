module Page.Collection exposing (Msg, init, update, view)

import Data.Meta
import Data.Playlist as Playlist exposing (..)
import Data.Session exposing (Session)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)
import Http
import Request.Request as Request
import Route
import Utils
import Views.Collection as Collection exposing (..)


init : Session -> ( Data.Meta.CollectionModel, Cmd Msg )
init session =
    ( { collection = Playlist.init
      , albums =
            { items = []
            , next = ""
            }
      }
    , Cmd.batch
        [ Http.send SetCollection <| Request.get "playlists/" (Utils.getId session.url) "" decodePlaylist session.token
        , Http.send SetCollectionTracks <| Request.get "playlists/" (Utils.getId session.url) "/tracks" decodePlaylistPaging session.token
        ]
    )


type Msg
    = SetCollection (Result Http.Error Playlist)
    | SetCollectionTracks (Result Http.Error PlaylistPaging)
    | SetCollectionTracksPaging (Result Http.Error PlaylistPaging)


update : Session -> Msg -> Data.Meta.CollectionModel -> ( Data.Meta.CollectionModel, Cmd Msg )
update session msg model =
    case msg of
        SetCollection (Ok e) ->
            ( { model | collection = e }
            , Cmd.none
            )

        SetCollection (Err e) ->
            ( model, Cmd.none )

        SetCollectionTracks (Ok e) ->
            ( { model | albums = e }
            , if e.next /= "" then
                Cmd.batch
                    [ Http.send SetCollectionTracksPaging <| Request.getPaging e.next decodePlaylistPaging session.token
                    ]

              else
                Cmd.none
            )

        SetCollectionTracks (Err e) ->
            ( model, Cmd.none )

        SetCollectionTracksPaging (Ok e) ->
            let
                concat =
                    model.albums.items ++ e.items
            in
            ( { model
                | albums =
                    { items = concat
                    , next = ""
                    }
              }
            , if e.next /= "" then
                Cmd.batch [ Http.send SetCollectionTracksPaging <| Request.getPaging e.next decodePlaylistPaging session.token ]

              else
                Cmd.none
            )

        SetCollectionTracksPaging (Err _) ->
            ( model, Cmd.none )


view : Session -> Data.Meta.CollectionModel -> ( String, List (Html Msg) )
view session model =
    ( model.collection.name, [ Collection.view model ] )
