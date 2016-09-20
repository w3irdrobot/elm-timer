require('../index.html');

const Elm = require('../elm/Timer.elm');
const main = document.getElementById('main');

Elm.Main.embed(main, {
  seconds: 100000,
  hoursThreshold: 48,
  formatUnderThreshold: '{H}::{M}::{S}'
});
