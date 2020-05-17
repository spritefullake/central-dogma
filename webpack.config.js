const path = require("path")
const HtmlWebpackPlugin = require("html-webpack-plugin")
const outputDir = path.resolve(__dirname, "build/")
const CompressionPlugin = require('compression-webpack-plugin')
const isProd = process.env.NODE_ENV === "production"
module.exports = {
  entry: "./src/Index.bs.js",
  mode: isProd ? "production" : "development",
  devtool: "source-map",
  output: {
    path: outputDir,
    filename: "Index.js",
    publicPath: '/'
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "index.html",
      inject: true
    }),
      new CompressionPlugin({
        filename: '[path].br[query]',
        algorithm: 'brotliCompress',
        test: /\.(js|css|html|svg|tsv)$/,
        compressionOptions: {
          // zlib’s `level` option matches Brotli’s `BROTLI_PARAM_QUALITY` option.
          level: 11,
        },
        threshold: 10240,
        minRatio: 0.8,
        deleteOriginalAssets: false,
      }),
  ],
  devServer: {
    compress: true,
    contentBase: outputDir,
    port: process.env.PORT || 8000,
    historyApiFallback: true,
    watchContentBase: true
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ["style-loader", {
          loader: "css-loader",
          options: { modules: false }
        }]
      },
      {
        test: /\.txt$/,
        use: 'raw-loader'
      },
      {
        test: /\.tsv$/,
        use: [
          {
            loader: 'file-loader',
          },
        ],
      }
    ]
  }
}