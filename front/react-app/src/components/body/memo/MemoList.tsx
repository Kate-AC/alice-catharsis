import * as React from "react";
import axios from "axios";
import queryString from "query-string";
import MemoBox from "./MemoBox";
import Tag from "./Tag";
import LoadingPanel from "../../LoadingPanel";

interface Props {
  key: number;
}

interface State {
  tags: Tag[];
  memos: Memo[];
}

interface Tag {
  id: number;
  name: string;
  color: string;
}

interface Memo {
  id: number;
  title: string;
  published_date: string; // eslint-disable-line camelcase
  tag_id: number; // eslint-disable-line camelcase
  tag_name: string; // eslint-disable-line camelcase
  tag_color: string; // eslint-disable-line camelcase
}

export default class MemoList extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      tags: [],
      memos: [],
    };
  }

  static getParam(): queryString.ParsedQuery<string> {
    return queryString.parse(window.location.search);
  }

  componentWillMount(): void {
    const params = MemoList.getParam();
    const { tagId } = params;

    this.loadMemos((tagId as string) || "");
    this.loadTags();
  }

  async loadTags(): Promise<void> {
    const { data } = await axios.get(
      `${process.env.REACT_APP_BACKEND_URL}/tags/index`
    );
    this.setState({ tags: data });
  }

  async loadMemos(tagId: string): Promise<void> {
    const { data } = await axios.get(
      `${process.env.REACT_APP_BACKEND_URL}/memos/index?tag_id=${tagId}`
    );
    this.setState({ memos: data });
  }

  render(): React.ReactElement {
    const { tags, memos } = this.state;

    return (
      <div>
        <LoadingPanel />
        <div id="contents-body">
          <h1>MEMO</h1>
          <div id="tag-box">
            <span>Tags:</span>
            {tags.map((item: Tag) => (
              <Tag
                key={item.id}
                id={item.id}
                name={item.name}
                color={item.color}
              />
            ))}
          </div>
          {memos.map((item: Memo) => (
            <MemoBox
              key={item.id}
              id={item.id}
              title={item.title}
              publishedDate={item.published_date}
              tagName={item.tag_name}
              tagColor={item.tag_color}
            />
          ))}
        </div>
      </div>
    );
  }
}
