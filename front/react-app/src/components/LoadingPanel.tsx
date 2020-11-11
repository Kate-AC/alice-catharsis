import * as React from "react";

interface Props {
  nowLoading: boolean;
}

export default function LoadingPanel(props: Props): React.ReactElement {
  const { nowLoading } = props;

  return (
    <aside className={"loading-panel " + (nowLoading ? "" : "loaded")}>
      <div className="loading" />
    </aside>
  );
}
