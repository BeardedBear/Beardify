module Data.Artist exposing
    ( Artist
    , ArtistSimplified
    , decodeArtist
    , decodeArtistSimplified
    , init
    )

import Data.Image
import Json.Decode as Decode exposing (Decoder(..), at, field)


init : Artist
init =
    { id = ""
    , images = []
    , name = ""
    , popularity = 0
    , type_ = ""
    }


type alias Artist =
    { id : String
    , images : List Data.Image.Image
    , name : String
    , popularity : Int
    , type_ : String
    }


decodeArtist : Decode.Decoder Artist
decodeArtist =
    Decode.map5 Artist
        (Decode.field "id" Decode.string)
        (Decode.at [ "images" ] (Decode.list Data.Image.decodeImage))
        (Decode.field "name" Decode.string)
        (Decode.field "popularity" Decode.int)
        (Decode.field "type" Decode.string)


type alias ArtistSimplified =
    { id : String
    , name : String
    }


decodeArtistSimplified : Decode.Decoder ArtistSimplified
decodeArtistSimplified =
    Decode.map2 ArtistSimplified
        (Decode.field "id" Decode.string)
        (Decode.field "name" Decode.string)
