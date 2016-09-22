require('../index.html');

const Elm = require('../elm/Timer.elm');
const main = document.getElementById('main');

const timer = Elm.Timer.embed(main, {
  seconds: 100000,
  // hoursThreshold: 48,
  formatUnderThreshold: '{H}::{M}::{S}',
  formatOverThreshold: 'Yo. It\'s gonna start pretty damn soon...{D} days!'
});

timer.ports.timerExpired.subscribe((message) => {
  console.log(`Well, hello, sir. We shall ${message}!`);
});
