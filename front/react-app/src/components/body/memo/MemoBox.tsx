import * as React from "react";
import { Link } from "react-router-dom";

interface Props {
  id: number;
  title: string;
  publishedDate: string;
  tagName: string;
  tagColor: string;
}

export default function MemoBox(props: Props): React.ReactElement {
  const { id, tagName, tagColor, publishedDate, title } = props;

  return (
    <Link className="memo-box" to={`/memo/${id}`}>
      <div className="title">{title}</div>
      <div className="attribute">
        <span className="date">{publishedDate}</span>
        <span className="tag" style={{ backgroundColor: tagColor }}>
          {tagName}
        </span>
      </div>
    </Link>
  );
}
