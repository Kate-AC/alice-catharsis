import * as React from "react";
import { Link } from "react-router-dom";
import Menu from "./header/Menu";

export default class Header extends React.Component {
  private headerRef: React.RefObject<HTMLElement> = React.createRef();

  componentDidMount(): void {
    const header = this.headerRef.current;

    if (header === null) return;

    window.addEventListener("scroll", () => {
      if (window.pageYOffset < 60) {
        header.classList.remove("responsive");
      } else {
        header.classList.add("responsive");
      }
    });
  }

  render(): React.ReactElement {
    return (
      <div id="contents-header">
        <article id="header-set" ref={this.headerRef}>
          <Link
            to="/"
            id="hero-title"
            onClick={() => {
              const btnTrigger = document.querySelector(".btn-trigger.active") as HTMLElement;
              if (btnTrigger === null) return;
              btnTrigger.click();
            }}
          >
            <span>A</span>
            lice Catharsis.
          </Link>
          <Menu />
        </article>
        <article id="header-set-dummy" />
        <hr className="line-style" />
      </div>
    );
  }
}
