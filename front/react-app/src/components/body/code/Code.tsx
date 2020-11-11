import * as React from "react";
import CodeBox from "./CodeBox";
import LoadingPanel from "../../LoadingPanel";

interface CodeHash {
  id: number;
  title: string;
  url: string;
  headline: string;
  description: string;
}

export default class Code extends React.Component {
  static get CODES(): CodeHash[] {
    return [
      {
        id: 10003,
        title: "alice-catharsis",
        url: "https://github.com/Kate-AC/alice-catharsis",
        headline: "このサイトの全てを置いてきた",
        description: `
          terraform使ってみたかったというのが大きい<br />
        `,
      },
      {
        id: 10002,
        title: "slack-daemon",
        url: "https://github.com/Kate-AC/slack-daemon",
        headline: "Slackの発言を監視できるChrome拡張",
        description: `
          なんか新規メッセージあるけどチャンネル切り替えがめんどい。<br />
          メンション来たけどタブを切り替えるのがめんどい。<br />
          Youtube見てるからメンション飛ばさないで貰えます？という人向けです。<br />
          webpackで3wayでコンパイルできるのが便利だったなーという感想。<br />
        `,
      },
      {
        id: 10001,
        title: "Eternal",
        url: "https://github.com/Kate-AC/Eternal",
        headline: "かつてこのサイトを構成していたPHPのMVCフレームワーク",
        description: `
          名前の由来は仮面ライダーWの仮面ライダーエターナルから。<br />
          元々学習のために作り始めましたが、3回の作り直しを経て現在の形になりました。<br />
          オレオレORM・オレオレDIコンテナ・オレオレテンプレートエンジン・オレオレテストエンジン等を実装しております。<br />
          デフォルトでVue.jsを組み込んでいますがもう使っていません。<br />
          ORMの実装がかなり厳しい感じになっているので、独立して作ったほうが良さそうだと思いました。<br />
        `,
      },
      {
        id: 10000,
        title: "PySync",
        url: "https://github.com/Kate-AC/PySync",
        headline: "デプロイ用のPythonのコマンド",
        description: `
          複雑なことは別にしておらず単なるrsyncコマンドのラッパーみたいな感じです。<br />
          VPN借りて掲示板を運営しているんですが、ソース上げるのがダルかったので学習がてら作りました。<br />
          全然README書いてないんですが、pysync.jsonに設定書いてコマンド叩くだけです。
        `,
      }
    ];
  }

  render(): React.ReactElement {
    return (
      <>
        <LoadingPanel nowLoading={false} />
        <div id="contents-body">
          <h1>CODE</h1>

          <p>
            ソースコード置き場です。
            <br />
            真面目に作ったやつだけ載せてます。
            <br />
            リファレンス的なやつはREADMEに書いてあるので感想やら補足を書きます。
            <br />
          </p>
          {Code.CODES.map((item) => (
            <CodeBox
              key={item.id}
              title={item.title}
              url={item.url}
              headline={item.headline}
              description={item.description}
            />
          ))}
        </div>
      </>
    );
  }
}
