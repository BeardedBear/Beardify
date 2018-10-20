module Drawer exposing (AlbumModel, ArtistModel, DrawerType(..), Model, init)

import Album exposing (..)
import Artist exposing (..)
import Track exposing (..)
import Youtube exposing (..)


type alias ArtistModel =
    { artist : Artist
    , albums : List Album
    , videos : List Video
    , topTracks : List Track
    , relatedArtists : List Artist
    }


type alias AlbumModel =
    { album : Album
    , tracks : List TrackSimplified
    }


type DrawerType
    = DrawArtist
    | DrawAlbum
    | Home
    | Releases
    | Listen


type alias Model =
    { drawerType : DrawerType
    , drawerArtist : ArtistModel
    , drawerAlbum : AlbumModel
    }


init =
    { drawerType = Home
    , drawerArtist =
        { artist =
            { id = ""
            , images = []
            , name = ""
            , popularity = 0
            , type_ = ""
            }
        , albums = []
        , videos = []
        , topTracks = []
        , relatedArtists = []
        }
    , drawerAlbum =
        { album =
            { album_type = ""
            , artists = []
            , id = ""
            , images = []
            , name = ""
            , release_date = ""
            , type_ = ""
            , uri = ""
            }
        , tracks = []
        }
    }
