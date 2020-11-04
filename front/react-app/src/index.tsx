import React from "react";
import ReactDOM from "react-dom";
import App from "./App";

require.context("./assets/scss/", true, /\.(sa|sc|c)ss$/);
require.context("./assets/js/", true, /\.(js|ts)$/);

ReactDOM.render(<App />, document.getElementById("root"));

