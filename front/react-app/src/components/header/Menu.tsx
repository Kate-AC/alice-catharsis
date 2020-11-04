import * as React from "react";
import MenuPanel from "./MenuPanel";

interface State {
  menus: MenuHash[];
}

interface MenuHash {
  id: number;
  name: string;
  path: string;
  isActive: boolean;
}

type Props = {};

export default class Menu extends React.Component<Props, State> {
  static isActive(path: string): boolean {
    return window.location.pathname.indexOf(path) > -1;
  }

  private switchActiveFuncHandler: () => void;

  constructor(props: Props) {
    super(props);
    this.state = {
      menus: [
        { id: 10000, name: "About", path: "/about", isActive: false },
        { id: 10001, name: "Memo", path: "/memo", isActive: false },
        { id: 10002, name: "Code", path: "/code", isActive: false },
        { id: 10003, name: "Api", path: "/api", isActive: false },
        { id: 10004, name: "Contact", path: "/contact", isActive: false },
      ],
    };
    this.switchActiveFuncHandler = this.switchActiveFunc.bind(this);
  }

  switchActiveFunc(): void {
    const { menus } = this.state;

    this.setState({
      menus: menus.map((item: MenuHash) => {
        const menuHash = item;
        menuHash.isActive = Menu.isActive(item.path);
        return menuHash;
      }),
    });
  }

  render(): React.ReactElement {
    const { menus } = this.state;

    return (
      <div id="menu">
        {menus.map((item: MenuHash) => (
          <MenuPanel
            key={item.id}
            name={item.name}
            path={item.path}
            isActive={Menu.isActive(item.path)}
            switchActive={this.switchActiveFuncHandler}
          />
        ))}
      </div>
    );
  }
}
