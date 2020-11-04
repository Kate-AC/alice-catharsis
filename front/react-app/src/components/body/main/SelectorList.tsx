import * as React from "react";
import Selector from "./Selector";

interface Props {
  loadImagesFunc: (arg0: string) => Promise<void>;
}

interface State {
  refs: React.RefObject<MyHTMLButtonElement>[];
}

interface Type {
  id: number;
  title: string;
  value: string;
}

type MyHTMLButtonElement = Selector & HTMLDivElement;

export default class SelectorList extends React.Component<Props, State> {
  static get TYPES(): Type[] {
    return [
      { id: 10000, title: "ALL", value: "all" },
      { id: 10001, title: "NORMAL", value: "normal" },
      { id: 10002, title: "R18", value: "r18" },
    ];
  }

  private getReleaseAllFuncHandler: () => void = this.getReleaseAllFunc.bind(
    this
  );

  constructor(props: Props) {
    super(props);

    const refs = [];
    for (let i = 0; i < SelectorList.TYPES.length; i += 1) {
      refs.push(React.createRef<MyHTMLButtonElement>());
    }

    this.state = { refs };
  }

  getReleaseAllFunc(): void {
    const { refs } = this.state;

    refs.forEach((ref: React.RefObject<MyHTMLButtonElement>) => {
      if (ref.current === null) return;
      ref.current.release();
    });
  }

  render(): React.ReactElement {
    const { refs } = this.state;
    const { loadImagesFunc } = this.props;

    return (
      <article id="selector-group">
        {SelectorList.TYPES.map((item, i) => (
          <Selector
            key={item.id}
            id={item.id}
            ref={refs[i]}
            loadImagesFunc={loadImagesFunc}
            releaseAllFunc={this.getReleaseAllFuncHandler}
            title={item.title}
            value={item.value}
          />
        ))}
      </article>
    );
  }
}
