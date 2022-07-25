var token;
var playerdata;

function setToken(token) {
  this.token = token;
}

function waitForToken() {
  if (typeof token !== "undefined") {
    const player = new Spotify.Player({
      name: 'My Music App',
      getOAuthToken: cb => { cb(token); }
    });

    // Error handling
    player.on('initialization_error', e => log('initialization_error', JSON.stringify(e)));
    player.on('authentication_error', e => log('authentication_error', JSON.stringify(e)));
    player.on('account_error', e => log('account_error', JSON.stringify(e)));
    player.on('playback_error', e => log('playback_error', JSON.stringify(e)));

    // Playback status updates
    player.on('player_state_changed', state => {
      log('player_state_changed', JSON.stringify(state))
      if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.player) {
        window.webkit.messageHandlers.player.postMessage(JSON.stringify(state));
      }
    });

    // Ready
    player.on('ready', data => {
      playerdata = data;
      log('Ready with Device ID ', playerdata.device_id);

      if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.device) {
        window.webkit.messageHandlers.device.postMessage(playerdata.device_id);
      }

      // Play a track using our new device ID
      play();
    });

    // Connect to the player!
    player.connect();

  }
  else {
    setTimeout(waitForToken, 100);
  }
}
// Set up the Web Playback SDK
window.onSpotifyPlayerAPIReady = () => {
  log('Waiting for token...')
  waitForToken()
}

const log = (...data) => {
  if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.log) {
    window.webkit.messageHandlers.log.postMessage(data);
  }
}

