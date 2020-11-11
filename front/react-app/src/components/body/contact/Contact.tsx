import * as React from "react";
import axios from "axios";
import LoadingPanel from "../../LoadingPanel";

type Props = {};

interface Status {
  value: string;
  status: string;
}

interface StatusToJp {
  [key: string]: string;
}

export default class Contact extends React.Component<Props, Status> {
  private handleForm: (arg0: React.ChangeEvent<HTMLTextAreaElement>) => void;

  private handleSubmit: (
    arg0: React.MouseEvent<HTMLButtonElement, MouseEvent>
  ) => void;

  private sendMessage: () => void;

  private statusToJp: StatusToJp = {
    open: "",
    sending: "送信中",
    done: "送信完了",
  };

  constructor(props: Props) {
    super(props);
    this.state = {
      value: "",
      status: "open",
    };

    this.handleForm = this.handleFormFunc.bind(this);
    this.handleSubmit = this.handleSubmitFunc.bind(this);
    this.sendMessage = this.sendMessageFunc.bind(this);
  }

  handleFormFunc(e: React.ChangeEvent<HTMLTextAreaElement>): void {
    this.setState({ value: e.target.value });
  }

  handleSubmitFunc(e: React.MouseEvent<HTMLButtonElement, MouseEvent>): void {
    const { status, value } = this.state;
    if (status !== "open") return;

    if (value.length < 10 || value.length > 3000) {
      window.alert("メッセージは10文字以上3000文字以内で入力してください。");
      return;
    }

    this.setState({ status: "sending" });
    this.sendMessage();
  }

  sendMessageFunc(): void {
    const { value } = this.state;

    axios
      .post(`${process.env.REACT_APP_BACKEND_URL}/contacts/mail`, JSON.stringify({
        message: value,
      }))
      .then((response) => {
        if (response.status !== 200) {
          this.setState({ status: "open" });
          window.alert("不明なエラーで送信できませんでした。");
          return;
        }
        this.setState({ status: "done" });
      });
  }

  render(): React.ReactElement {
    const { value, status } = this.state;

    return (
      <>
        <LoadingPanel nowLoading={false} />
        <div id="contents-body">
          <h1>CONTACT</h1>
          <p>
            下記のフォームからメッセージを送れます。
            <br />
            ご意見やご感想などがあればお使いください。
            <br />
            基本的に届いたメッセージが公開されることはありませんが、
            <br />
            内容によってはMEMOページで公開・返答する可能性はあります。
          </p>
          <div id="contact-form">
            <textarea
              id="field"
              placeholder="3000文字まで"
              value={value}
              onChange={this.handleForm}
            />
            <div>
              <button
                type="button"
                className={status === "open" ? "" : "disabled"}
                onClick={this.handleSubmit}
              >
                送信する
              </button>
              <span id="status">{this.statusToJp[status]}</span>
            </div>
          </div>
        </div>
      </>
    );
  }
}
