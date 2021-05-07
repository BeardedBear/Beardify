import { AlbumSimplified } from "./Album";
import { Track } from "./Track";

export interface ArtistPage {
  artist: Artist;
  topTracks: ArtistTopTracks;
  albums: AlbumSimplified[];
  singles: AlbumSimplified[];
  relatedArtists: RelatedArtists;
  followStatus: boolean;
}

export interface ArtistTopTracks {
  tracks: Track[];
}

export interface Image {
  height: number;
  url: string;
  width: number;
}

export interface ExternalUrls {
  spotify: string;
}

export interface RelatedArtists {
  artists: Artist[];
}

export interface ArtistSimplified {
  external_urls: ExternalUrls;
  href: string;
  id: string;
  name: string;
  type: string;
  uri: string;
}
export interface Artist {
  external_urls: {
    spotify: string;
  };
  followers: {
    href: null;
    total: number;
  };
  genres: string[];
  href: string;
  id: string;
  images: Image[];
  name: string;
  popularity: number;
  type: string;
  uri: string;
}
