import * as React from "react";
import Gallery from "./Gallery";
import LoadingPanel from "../../LoadingPanel";

export default function Body(): React.ReactElement {
  return (
    <div style={{ minHeight: "800px" }}>
      <LoadingPanel />
      <div id="contents-body">
        <Gallery />
      </div>
    </div>
  );
}
