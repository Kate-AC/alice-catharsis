import * as React from "react";
import { Link } from "react-router-dom";

interface Props {
  id: number;
  name: string;
  color: string;
}

export default function Tag(props: Props): React.ReactElement {
  const { id, color, name } = props;

  return (
    <Link
      className="tag"
      style={{ backgroundColor: color }}
      to={`/memo?tagId=${id}`}
    >
      {name}
    </Link>
  );
}
