import * as React from "react";
import axios from "axios";
import HighLight from "highlight.js";
import Tag from "./Tag";
import LoadingPanel from "../../LoadingPanel";

type Props = {};

interface State {
  tag: Tag;
  memo: Memo;
}

interface Tag {
  id: number;
  name: string;
  color: string;
}

interface Memo {
  body: string;
  title: string;
  published_date: string; // eslint-disable-line camelcase
}

export default class MemoSingle extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      memo: { body: "", title: "", published_date: "" },
      tag: { id: 0, name: "", color: "" },
    };
  }

  componentWillMount(): void {
    this.loadMemo(MemoSingle.getMemoId());
  }

  componentDidMount(): void {
    HighLight.initHighlighting();
  }

  static getMemoId(): string {
    return window.location.pathname.substr("/memo/".length);
  }

  async loadMemo(memoId: string): Promise<void> {
    const result = await axios.get(
      `${process.env.REACT_APP_BACKEND_URL}/memos/show?memo_id=${memoId}`
    );
    this.setState({ memo: result.data.memo, tag: result.data.tag });
  }

  render(): React.ReactElement {
    const { memo, tag } = this.state;

    return (
      <div>
        <LoadingPanel />
        <div id="contents-body">
          <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.15.10/styles/monokai-sublime.min.css"
          />
          <hr className="dot" />
          <h3>{memo.title}</h3>
          <div>
            <span className="date">{memo.published_date}</span>
            <Tag key={tag.id} id={tag.id} name={tag.name} color={tag.color} />
          </div>
          <hr className="dot" />
          <div
            className="sentences"
            dangerouslySetInnerHTML={{ __html: memo.body }}
          />
          <hr className="dot" />
        </div>
      </div>
    );
  }
}
