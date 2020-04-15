const path = require("path")
const HtmlWebpackPlugin = require("html-webpack-plugin")
const outputDir = path.resolve(__dirname, "build/")

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
      template: "indexProduction.html",
      inject: true
    })
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
      }
    ]
  }
}