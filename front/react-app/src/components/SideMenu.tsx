import * as React from "react";

export default class SideMenu extends React.Component {
  private btnTriggerRef: React.RefObject<HTMLDivElement> = React.createRef();

  componentDidMount(): void {
    const ref = this.btnTriggerRef.current;
    const menu = document.getElementById("menu");
    if (ref === null || menu === null) return;

    ref.addEventListener("click", () => {
      menu.classList.toggle("opened");
      ref.classList.toggle("active");
    });
  }

  render(): React.ReactElement {
    return (
      <article id="side-button-set">
        <div className="btn-trigger" ref={this.btnTriggerRef}>
          <span />
          <span />
          <span />
        </div>
        <div className="social-icon">
          <a
            href="https://www.pixiv.net/users/294167"
            className="pixiv"
            target="_blank"
            rel="noopener noreferrer"
          >
            {" "}
          </a>
          <a
            href="https://twitter.com/AliceCatharsis"
            className="twitter"
            target="_blank"
            rel="noopener noreferrer"
          >
            {" "}
          </a>
          <a
            href="https://github.com/Kate-AC"
            className="github"
            target="_blank"
            rel="noopener noreferrer"
          >
            {" "}
          </a>
        </div>
      </article>
    );
  }
}
