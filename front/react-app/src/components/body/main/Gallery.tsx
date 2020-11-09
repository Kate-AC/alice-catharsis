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
  private loadImagesFuncHandler: (
    arg0: string
  ) => Promise<void> = this.loadImagesFunc.bind(this);

  constructor(props: Props) {
    super(props);

    this.state = {
      images: [],
    };
  }

  componentWillMount(): void {
    this.loadImagesFunc(SelectorList.TYPES[0].value);
  }

  async loadImagesFunc(targetType: string): Promise<void> {
    await axios
      .get(
        `${process.env.REACT_APP_BACKEND_URL}/images/index?target_type=${targetType}`
      )
      .then((result) => {
        this.setState({ images: result.data });
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
