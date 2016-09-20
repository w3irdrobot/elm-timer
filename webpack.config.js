const path = require('path');

module.exports = {
  entry: {
    app: [
      './src/js/index.js'
    ]
  },
  output: {
    path: path.resolve(`${__dirname}/build`),
    filename: '[name].bundle.js'
  },
  module: {
    loaders: [
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file?name=[name].[ext]'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack'
      }
    ],
    noParse: /\.elm$/
  },
  devServer: {
    inline: true,
    stats: {
      colors: true
    }
  }
};
