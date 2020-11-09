const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const webpack = require('webpack');

module.exports = {
  mode: 'development',
  entry: './src/index.tsx',
  devtool: 'inline-source-map',
  output:
    {
      filename: 'js/main.js',
      path: path.resolve(__dirname, 'public')
    }
  ,
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        exclude: ["/node_mocules/"],
        use: [
          'ts-loader'
        ]
      },
      {
        test: /\.(sa|sc|c)ss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'sass-loader'
        ]
      }
    ]
  },
  resolve: {
    modules: ['node_modules'],
    extensions: ['.ts', '.tsx', '.js', 'jsx']
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'css/main.css',
    })
  ]
};

