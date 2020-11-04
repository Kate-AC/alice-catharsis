import * as React from "react";
import { Link } from "react-router-dom";

interface Props {
  name: string;
  path: string;
  isActive: boolean;
  switchActive: () => void;
}

export default function MenuPanel(props: Props): React.ReactElement {
  const { isActive, path, name } = props;

  return (
    <Link to={path}>
      <button
        type="button"
        className="panel"
        onClick={() => {
          props.switchActive();
          const btnTrigger = document.querySelector(".btn-trigger.active") as HTMLElement;
          if (btnTrigger === null) return;
          btnTrigger.click();
        }}
      >
        <span className={isActive ? "active" : ""}>{name}</span>
      </button>
    </Link>
  );
}
