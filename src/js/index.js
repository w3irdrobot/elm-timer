require('../index.html');

const Elm = require('../elm/Timer.elm');
const main = document.getElementById('main');

const nulls = {
  hoursThreshold: null,
  formatUnderThreshold: null,
  formatOverThreshold: null
};

const flags = {
  seconds: 500000,
  formatOverThreshold: 'Yo. It\'s gonna start pretty damn soon...{D} days!'
};

const timer = Elm.Timer.embed(main, Object.assign({}, nulls, flags));

timer.ports.timerExpired.subscribe((message) => {
  console.log(`Well, hello, sir. We shall ${message}!`);
});
