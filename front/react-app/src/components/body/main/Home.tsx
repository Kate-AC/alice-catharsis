import * as React from "react";
import Gallery from "./Gallery";

export default function Body(): React.ReactElement {
  return (
    <div style={{ minHeight: "800px" }}>
      <div id="contents-body">
        <Gallery />
      </div>
    </div>
  );
}
