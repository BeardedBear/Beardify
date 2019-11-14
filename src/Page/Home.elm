module Page.Home exposing (Model, Msg(..), init, update, view)

import Data.Device as Device
import Data.Session as Session exposing (Session)
import Html exposing (..)
import Html.Attributes exposing (..)
import Views.Device as Device
import Views.Player as Player
import Views.Sidebar as Sidebar
import Views.Topbar as Topbar


type alias Model =
    { device : Device.Model }


type Msg
    = DeviceMsg Device.Msg


init : Session -> ( Model, Session, Cmd Msg )
init session =
    let
        ( deviceModel, deviceCmd ) =
            Device.init session
    in
    ( { device = deviceModel }
    , session
    , Cmd.batch [ Cmd.map DeviceMsg deviceCmd ]
    )


update : Session -> Msg -> Model -> ( Model, Session, Cmd Msg )
update session msg model =
    case msg of
        DeviceMsg deviceMsg ->
            let
                ( deviceModel, newSession, deviceCmd ) =
                    Device.update session deviceMsg model.device
            in
            ( { model | device = deviceModel }
            , newSession
            , Cmd.batch [ Cmd.map DeviceMsg deviceCmd ]
            )


view : Session -> Model -> ( String, List (Html Msg) )
view session model =
    ( "Home"
    , [ Topbar.view session
      , div [ class "App__body" ]
            [ Sidebar.view
            , div [ class "Content" ]
                [ div [ class "Page" ]
                    [ div [ class "Flex fullHeight" ]
                        [ div [ class "Flex__full HelperScrollArea" ]
                            [ div [ class "Artist__body HelperScrollArea__target" ]
                                [ div [ class "Flex spaceBetween centeredVertical" ]
                                    [ h1 [ class "Heading first" ] [ text "Pain of Salvation" ]
                                    , button [ class "Button" ] [ text "Follow" ]
                                    ]
                                , div [ class "ArtistLinks" ]
                                    [ a [ class "ArtistLinks__item", href "#" ] [ i [class "ArtistLinks__icon icon-wikipedia"][],text "Wikipedia" ]
                                    , a [ class "ArtistLinks__item", href "#" ] [ i [class "ArtistLinks__icon icon-sputnik"][],text "Sputnik" ]
                                    , a [ class "ArtistLinks__item", href "#" ] [ i [class "ArtistLinks__icon icon-discogs"][],text "Discogs" ]
                                    , a [ class "ArtistLinks__item", href "#" ] [ i [class "ArtistLinks__icon icon-magnifying-glass"][],text "Google" ]
                                    ]
                                , div [ class "Artist__top" ]
                                    [ div []
                                        [ h2 [ class "Heading second" ] [ text "Top songs" ]
                                        , div [ class "Track Flex centeredVertical" ]
                                            [ img [ class "Track__cover", src "https://i.scdn.co/image/ab67616d00004851b6db1b15fbf0d6a11de4b13c" ] []
                                            , div [ class "Track__name Flex__full" ] [ text "Sisters" ]
                                            , div [class "Track__duration"] [ text "6:15" ]
                                            ]
                                        , div [ class "Track Flex centeredVertical" ]
                                            [ img [ class "Track__cover", src "https://i.scdn.co/image/ab67616d00004851a45cd272063bc487a0615791" ] []
                                            , div [ class "Track__name Flex__full" ] [ text "Meaningless" ]
                                            , div [class "Track__duration"] [ text "4:47" ]
                                            ]
                                        , div [ class "Track Flex centeredVertical" ]
                                            [ img [ class "Track__cover", src "https://i.scdn.co/image/ab67616d000048513ef2598ca7bf8c4c9d317b9e" ] []
                                            , div [ class "Track__name Flex__full" ] [ text "Undertow" ]
                                            , div [class "Track__duration"] [ text "4:47" ]
                                            ]
                                        , div [ class "Track Flex centeredVertical" ]
                                            [ img [ class "Track__cover", src "https://i.scdn.co/image/ab67616d00004851a45cd272063bc487a0615791" ] []
                                            , div [ class "Track__name Flex__full" ] [ text "Silent Gold" ]
                                            , div [class "Track__duration"] [ text "3:23" ]
                                            ]
                                        , div [ class "Track Flex centeredVertical" ]
                                            [ img [ class "Track__cover", src "https://i.scdn.co/image/ab67616d00004851a45cd272063bc487a0615791" ] []
                                            , div [ class "Track__name Flex__full" ] [ text "On a Thuesday" ]
                                            , div [class "Track__duration"] [ text "10:22" ]
                                            ]
                                        ]
                                    , div []
                                        [ h2 [ class "Heading second" ] [ text "Similar artists" ]
                                        , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eget convallis justo, eget sodales eros. Curabitur massa lacus, convallis non metus pretium, iaculis venenatis tellus. Morbi faucibus scelerisque ex, non ullamcorper lorem semper non." ]
                                        ]
                                    ]
                                , div []
                                    [ h2 [ class "Heading second" ] [ text "Albums" ]
                                    , div [ class "AlbumList" ]
                                        [ div [ class "Album" ]
                                            [ img [ class "Album__cover", src "https://i.scdn.co/image/ab67616d00001e02a45cd272063bc487a0615791" ] []
                                            , div [class "Album__name"] [ text "In The Passing Light of Day" ]
                                            , div [class "Album__release"] [ text "(2017)" ]
                                            ]
                                        , div [ class "Album" ]
                                            [ img [ class "Album__cover", src "https://i.scdn.co/image/ab67616d00001e026112c09de48809873488eb97" ] []
                                            , div [class "Album__name"] [ text "Remedy Lane Re:lived" ]
                                            , div [class "Album__release"] [ text "(2016)" ]
                                            ]
                                        , div [ class "Album" ]
                                            [ img [ class "Album__cover", src "https://i.scdn.co/image/ab67616d00001e02951a174f717e2b4fb57c90ef" ] []
                                            , div [class "Album__name"] [ text "Remedy Lane Re:mixed" ]
                                            , div [class "Album__release"] [ text "(2016)" ]
                                            ]
                                        , div [ class "Album" ]
                                            [ img [ class "Album__cover", src "https://i.scdn.co/image/ab67616d00001e02749c330ea008a87fb3f19dd1" ] []
                                            , div [class "Album__name"] [ text "Falling Home" ]
                                            , div [class "Album__release"] [ text "(2014)" ]
                                            ]
                                        , div [ class "Album" ]
                                            [ img [ class "Album__cover", src "https://i.scdn.co/image/ab67616d00001e02c2d2935f63289fc4d2785b3d" ] []
                                            , div [class "Album__name"] [ text "Road Salt Two" ]
                                            , div [class "Album__release"] [ text "(2011)" ]
                                            ]
                                        , div [ class "Album" ]
                                            [ img [ class "Album__cover", src "https://i.scdn.co/image/ab67616d00001e02b6db1b15fbf0d6a11de4b13c" ] []
                                            , div [class "Album__name"] [ text "Road Salt One" ]
                                            , div [class "Album__release"] [ text "(2010)" ]
                                            ]
                                        ]
                                    ]
                                , div []
                                    [ h2 [ class "Heading second" ] [ text "EPs" ]
                                    , div [ class "AlbumList" ]
                                        [ div [ class "Album" ]
                                            [ img [ class "Album__cover", src "https://i.scdn.co/image/ab67616d00001e02a45cd272063bc487a0615791" ] []
                                            , div [class "Album__name"] [ text "In The Passing Light of Day" ]
                                            , div [class "Album__release"] [ text "(2017)" ]
                                            ]
                                        , div [ class "Album" ]
                                            [ img [ class "Album__cover", src "https://i.scdn.co/image/ab67616d00001e02a45cd272063bc487a0615791" ] []
                                            , div [class "Album__name"] [ text "Remedy Lane Re:lived" ]
                                            , div [class "Album__release"] [ text "(2016)" ]
                                            ]
                                        , div [ class "Album" ]
                                            [ img [ class "Album__cover", src "https://i.scdn.co/image/ab67616d00001e02a45cd272063bc487a0615791" ] []
                                            , div [class "Album__name"] [ text "Remedy Lane Re:mixed" ]
                                            , div [class "Album__release"] [ text "(2016)" ]
                                            ]
                                        ]
                                    ]
                                , div []
                                    [ h2 [ class "Heading second" ] [ text "Singles" ]
                                    , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eget convallis justo, eget sodales eros. Curabitur massa lacus, convallis non metus pretium, iaculis venenatis tellus. Morbi faucibus scelerisque ex, non ullamcorper lorem semper non. Nunc sapien turpis, finibus ac egestas eget, aliquam at magna. Cras bibendum sit amet elit sed ornare. Maecenas et neque scelerisque, interdum dui eu, tincidunt augue. Pellentesque vitae tincidunt nisl, id maximus massa. Cras tempor, orci at gravida aliquam, nunc elit porta augue, a varius arcu odio vitae risus. Curabitur eget leo tristique, laoreet libero et, posuere justo. Phasellus non consectetur dolor. Suspendisse ac auctor nisi. Donec rhoncus neque at tortor euismod, at semper nunc bibendum. Nulla in efficitur lacus, sit amet interdum felis. Donec id est vehicula odio feugiat suscipit quis congue quam. Donec eu purus tristique, tincidunt quam vitae, lobortis lacus." ]
                                    ]
                                ]
                            ]
                        , div [ class "Artist__videos" ] [ text "youtube" ]
                        ]
                    ]
                , div [ class "Content__bottom" ]
                    [ Player.view
                    , Device.view model.device
                        |> Html.map DeviceMsg
                    ]
                ]
            ]
      ]
    )
