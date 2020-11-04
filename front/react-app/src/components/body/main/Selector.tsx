import * as React from "react";

interface Props {
  id: number;
  ref: React.RefObject<HTMLDivElement>;
  loadImagesFunc: (arg0: string) => Promise<void>;
  releaseAllFunc: () => void;
  title: string;
  value: string;
}

interface State {
  selected: boolean;
}

export default class Selector extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { selected: props.value === "all" };
  }

  select(): void {
    const { releaseAllFunc, loadImagesFunc, value } = this.props;

    releaseAllFunc();
    loadImagesFunc(value);
    this.setState({ selected: true });
  }

  release(): void {
    this.setState({ selected: false });
  }

  render(): React.ReactElement {
    const { selected } = this.state;
    const { title } = this.props;

    return (
      <button
        type="button"
        className={selected ? "selected" : ""}
        onClick={this.select.bind(this)}
      >
        {title}
      </button>
    );
  }
}
