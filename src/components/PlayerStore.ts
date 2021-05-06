import { ActionTree, MutationTree } from "vuex";
import { instance } from "../api";
import { Player, defaultPlaybackState, defaultUserDevice } from "../@types/Player";
import { RootState } from "../@types/rootStore";

const state: Player = {
  devices: {
    activeDevice: defaultUserDevice,
    list: []
  },
  currentlyPlaying: {
    track: defaultPlaybackState
  }
};

// MUTATIONS

export enum Mutations {
  GET_DEVICE_LIST = "GET_DEVICE_LIST",
  SET_THIS_DEVICE = "SET_THIS_DEVICE",
  PLAYER_STATE_CHANGED = "PLAYER_STATE_CHANGED"
}

const mutations: MutationTree<Player> = {
  [Mutations.GET_DEVICE_LIST](state, data: UserDevice[]): void {
    state.devices.list = data;
  },

  [Mutations.SET_THIS_DEVICE](state, data: UserDevice): void {
    state.devices.activeDevice = data;
  },

  [Mutations.PLAYER_STATE_CHANGED](state, customEvent: Spotify.PlaybackState): void {
    state.currentlyPlaying.track = customEvent;
  }
};

// ACTIONS

export enum PlayerActions {
  getDeviceList = "getDeviceList",
  setDevice = "setDevice"
}

const actions: ActionTree<Player, RootState> = {
  [PlayerActions.getDeviceList](store) {
    instance.get<UserDevicesResponse>("me/player/devices").then(({ data }) => {
      // On set le dernier device actif par defaut
      const lastActiveDevice = data.devices.filter(el => el.name === store.state.devices.activeDevice.name).shift();
      const haveDeviceActive = data.devices.filter(d => d.is_active);

      if (!haveDeviceActive.length) {
        if (lastActiveDevice !== undefined) store.dispatch(PlayerActions.setDevice, lastActiveDevice);
      }

      // On met a jour la liste des devices
      store.commit(Mutations.GET_DEVICE_LIST, data.devices);
    });
  },

  [PlayerActions.setDevice](store, device: UserDevice) {
    store.commit(Mutations.SET_THIS_DEVICE, device);
    instance.put("me/player", { device_ids: [device.id] });
  }
};

export default {
  actions,
  mutations,
  namespaced: true,
  state
};
