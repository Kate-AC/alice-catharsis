import * as React from "react";
import { BrowserRouter, Route } from "react-router-dom";
import SideMenu from "./SideMenu";
import Header from "./Header";
import Home from "./body/main/Home";
import About from "./body/about/About";
import Code from "./body/code/Code";
import Memo from "./body/memo/Memo";
import Api from "./body/api/Api";
import Contact from "./body/contact/Contact";
import Footer from "./Footer";

export default function Window(): React.ReactElement {
  return (
    <BrowserRouter>
      <div id="window">
        <main>
          <SideMenu />
          <Header />
          <div id="contents">
            <Route exact path="/" render={() => <Home />} />
            <Route path="/about" render={() => <About />} />
            <Route path="/code" render={() => <Code />} />
            <Route path="/memo" render={() => <Memo />} />
            <Route path="/api" render={() => <Api />} />
            <Route path="/contact" render={() => <Contact />} />
          </div>
          <Footer />
        </main>
        <figure id="background-img">
          <div className="frame">
            <img src="/images/bg_01.jpg" />
          </div>
        </figure>
      </div>
    </BrowserRouter>
  );
}
