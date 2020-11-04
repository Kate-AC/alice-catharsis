import * as React from "react";
import axios from "axios";
import ImagePanel from "./ImagePanel";
import SelectorList from "./SelectorList";

type Props = {};

interface State {
  images: Image[];
}

interface Image {
  id: number;
  title: string;
  url: string;
  target_type: string; // eslint-disable-line camelcase
  thumbnail: string;
  adjusty: string;
}

export default class Gallery extends React.Component<Props, State> {
  private mounted = false;

  private loadImagesFuncHandler: (
    arg0: string
  ) => Promise<void> = this.loadImagesFunc.bind(this);

  constructor(props: Props) {
    super(props);

    this.state = {
      images: [],
    };
  }

  componentDidMount(): void {
    this.mounted = true;
    this.loadImagesFunc(SelectorList.TYPES[0].value);
  }

  componentWillUnmount(): void {
    this.mounted = false;
  }

  async loadImagesFunc(targetType: string): Promise<void> {
    await axios
      .get(
        `${process.env.REACT_APP_BACKEND_URL}/api/images?target_type=${targetType}`
      )
      .then((result) => {
        if (this.mounted) {
          this.setState({ images: result.data });
        }
      });
  }

  render(): React.ReactElement {
    const { images } = this.state;

    return (
      <>
        <SelectorList loadImagesFunc={this.loadImagesFuncHandler} />
        <article id="gallery">
          {images.map((item: Image) => (
            <ImagePanel
              key={item.id}
              title={item.title}
              url={item.url}
              targetType={item.target_type}
              thumbnail={item.thumbnail}
              adjusty={item.adjusty}
            />
          ))}
        </article>
      </>
    );
  }
}
