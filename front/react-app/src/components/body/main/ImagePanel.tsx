import * as React from "react";

interface Props {
  key: number;
  title: string;
  url: string;
  targetType: string;
  thumbnail: string;
  adjusty: string;
}

interface State {
  isLoaded: boolean;
}

export default class ImagePanel extends React.Component<Props, State> {
  private mounted = false;

  private imageRef: React.RefObject<HTMLImageElement> = React.createRef();

  constructor(props: Props) {
    super(props);
    this.state = { isLoaded: false };
  }

  componentDidMount(): void {
    this.mounted = true;
    this.createScrollEvent()(); // 初回実行
    this.setEvent();
  }

  componentDidUpdate() {
    this.createScrollEvent()(); // 初回実行
  }

  componentWillUnmount(): void {
    this.mounted = false;
  }

  setEvent(): void {
    const image = this.imageRef.current;
    if (image === null) return;

    image.addEventListener("load", () => {
      if (!this.mounted) return;

      image.classList.add("visible");
      this.setState({ isLoaded: true });
    });

    window.addEventListener("scroll", this.createScrollEvent());
  }

  createScrollEvent(): () => void {
    const image = this.imageRef.current;
    const { isLoaded } = this.state;

    return () => {
      if (isLoaded || image === null) return;

      const element = image.parentNode as Element;
      const rect = element.getBoundingClientRect();

      if (
        (rect.top <= window.innerHeight && window.innerHeight <= rect.bottom) ||
        (rect.top <= 0 && rect.bottom >= 0) ||
        (rect.top > 0 && rect.bottom <= window.innerHeight)
      ) {
        image.setAttribute("src", image.getAttribute("data-src") || "");
      }
    };
  }

  render(): React.ReactElement {
    const { title, thumbnail, url, targetType, adjusty } = this.props;
    const attr = JSON.parse(adjusty);

    return (
      <div className="image-panel">
        <span
          className="filter-clear"
          role="link"
          aria-label="Show title."
          tabIndex={0}
          onClick={() => window.open(url, "_blank")}
          onKeyDown={() => window.open(url, "_blank")}
        />
        {targetType === "r18" && <span className="belt-r18">R18</span>}
        <span className="filter-effect" />
        <span className="title">{title}</span>
        <img
          alt={title}
          ref={this.imageRef}
          className="thumbnail"
          data-src={thumbnail}
          style={{ width: attr.width, top: attr.top, left: attr.left }}
        />
      </div>
    );
  }
}
