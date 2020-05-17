const path = require("path")
const HtmlWebpackPlugin = require("html-webpack-plugin")
const outputDir = path.resolve(__dirname, "build/")
const CompressionPlugin = require('compression-webpack-plugin')
const isProd = process.env.NODE_ENV === "production"
const webpack = require("webpack")

const entry = isProd ? "./src/Index.bs.js" : [`webpack-hot-middleware/client`,"./src/Index.bs.js"]
const mode = isProd ? "production" : "development"
const devtool = isProd ? "" : "source-map"
let plugins = [
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
]
if(!isProd){
  //add hot module support for dev
  plugins = [...plugins, new webpack.HotModuleReplacementPlugin()]
}
module.exports = {
  entry,
  mode,
  devtool,
  output: {
    path: outputDir,
    filename: "Index.js",
    publicPath: '/',
  },
  plugins,
  devServer: {
    compress: true,
    contentBase: outputDir,
    port: process.env.PORT || 8000,
    historyApiFallback: true,
    watchContentBase: true,
    hot: true,
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