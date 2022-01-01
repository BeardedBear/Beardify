import { defineStore } from "pinia";
import { defaultPlaylist } from "../../@types/Defaults";
import { Paging } from "../../@types/Paging";
import { Playlist, PlaylistPage, PlaylistTrack } from "../../@types/Playlist";
import { TrackToRemove } from "../../@types/Track";
import { instance } from "../../api";
import { useSidebar } from "../../components/sidebar/SidebarStore";
import { useAuth } from "../auth/AuthStore";

export const usePlaylist = defineStore("playlist", {
  state: (): PlaylistPage => ({
    playlist: defaultPlaylist,
    tracks: [],
    followed: false,
  }),

  actions: {
    async getPlaylist(url: string) {
      this.playlist = (await instance().get<Playlist>(url)).data;
      this.followed = (
        await instance().get<boolean[]>(`playlists/${this.playlist.id}/followers/contains?ids=${useAuth().me?.id}`)
      ).data.shift();
    },

    async clean() {
      this.playlist = defaultPlaylist;
      this.tracks = [];
    },

    getTracks(url: string) {
      instance()
        .get<Paging<PlaylistTrack>>(url)
        .then((e) => {
          this.tracks = e.data.items.filter((e) => e.track);
          if (e.data.next) {
            instance()
              .get<Paging<PlaylistTrack>>(e.data.next)
              .then((f) => {
                this.tracks = this.tracks.concat(f.data.items.filter((g) => g.track));
              });
          }
        });
    },

    removeTracks(tracks: TrackToRemove[]) {
      this.tracks = this.tracks.filter((e) => !tracks.map((e) => e.uri).includes(e.track.uri));
    },

    removeSong(songUri: string) {
      this.tracks = this.tracks.filter((t) => t.track.uri !== songUri);
    },

    followPlaylist(playlistId: string) {
      instance()
        .put(`playlists/${playlistId}/followers`)
        .then(() => {
          this.followed = true;
          useSidebar().refreshPlaylists();
        });
    },
  },
});
