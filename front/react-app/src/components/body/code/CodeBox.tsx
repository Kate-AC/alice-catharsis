import * as React from "react";

interface Props {
  title: string;
  url: string;
  headline: string;
  description: string;
}

interface State {
  opened?: boolean;
}

export default class CodeBox extends React.Component<Props, State> {
  private ref: React.RefObject<HTMLDivElement> = React.createRef();

  constructor(props: Props) {
    super(props);
    this.state = { opened: false };
  }

  componentDidMount(): void {
    const { current } = this.ref;

    if (current === null) return;

    current.addEventListener("click", () => {
      const { opened } = this.state;
      this.setState({ opened: !opened });
    });
  }

  render(): React.ReactElement {
    const { opened } = this.state;
    const { title, url, headline, description } = this.props;

    return (
      <div className="code-box">
        <div
          className={`header ${opened ? "opened" : "closed"}`}
          ref={this.ref}
        >
          <span />
          <h2>{title}</h2>
        </div>
        <div className={`contents ${opened ? "opened" : "closed"}`}>
          <p>
            <a href={url} target="_blank">{url}</a>
          </p>
          <p>{headline}</p>
          <p dangerouslySetInnerHTML={{ __html: description }} />
        </div>
      </div>
    );
  }
}
