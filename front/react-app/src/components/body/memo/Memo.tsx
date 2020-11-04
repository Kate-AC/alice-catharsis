import * as React from "react";
import { Route } from "react-router-dom";
import MemoList from "./MemoList";
import MemoSingle from "./MemoSingle";

export default function Memo(): React.ReactElement {
  return (
    <div style={{ minHeight: "800px" }}>
      <Route
        exact
        path="/memo"
        render={() => <MemoList key={Math.random()} />}
      />
      <Route path="/memo/*" render={() => <MemoSingle />} />
    </div>
  );
}
