window.onSpotifyWebPlaybackSDKReady = () => {
  const player = new Spotify.Player({
    name: "Beardify",
    getOAuthToken: cb => cb(JSON.parse(localStorage.getItem("beardify") || "").auth.auth.accessToken),
    volume: 0.5
  });

  player.connect();
  player.on("authentication_error", () => dispatchEvent(new CustomEvent("noAccess")));

  // FUCK YOU SDK
  // setInterval(() => {
  //   player?.getCurrentState().then(state => {
  //     dispatchEvent(new CustomEvent("playerStateChanged", { detail: state }));
  //   });
  // }, 500);

  player.addListener("ready", ({ device_id }) => {
    dispatchEvent(
      new CustomEvent("initdevice", {
        detail: { thisDevice: device_id }
      })
    );
  });
};
