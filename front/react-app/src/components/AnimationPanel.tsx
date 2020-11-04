import * as React from "react";

export default class AnimationPanel extends React.Component {
  static renderLoading(): React.ReactElement {
    return <div className="loader" />;
  }

  static renderOpening(): React.ReactElement {
    return (
      <div id="frame-1">
        <span>少</span>
        <span>女</span>
        <span>カ</span>
        <span>タ</span>
        <span>ル</span>
        <span>シ</span>
        <span>ス</span>
        <span>。</span>
      </div>
    );
  }

  render(): React.ReactElement {
    return <aside id="animation-panel">{AnimationPanel.renderLoading()}</aside>;
  }
}
