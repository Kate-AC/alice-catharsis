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
        id: 10000,
        title: "Eternal",
        url: "https://github.com/Kate-AC/Eternal",
        headline: "かつてこのサイトを構成していたPHPのMVCフレームワーク。",
        description: `
          名前の由来は仮面ライダーWの仮面ライダーエターナルから。<br />
          元々学習のために作り始めましたが、3回の作り直しを経て現在の形になりました。<br />
          オレオレORM・オレオレDIコンテナ・オレオレテンプレートエンジン・オレオレモッククラス等を<br />
          実装しております。完全にオナニーです。本当にありがとうございました。<br />
          テンプレートエンジンの拡張子<strong>arc</strong>は仮面ライダーアークから。<br />
          オレオレモッククラス<strong>Phantom</strong>は仮面ライダーウィザードのファントムから。<br />
          jQuery絶対殺すマンなのでデフォルトでVue.jsを組み込んでいます。<br />
          DOM操作がバニラjsでも簡単になった今、本当にjQuery要らなくなったなーという感じです。<br />
          ORMの実装がエンティティのアノテーションにどこまで頼るか等まだまだ改善点が多いと思います。<br />
          joinが絡むと急にコードが複雑になるなあという感じです。<br />
          もうちょいinterfaceとか使ったらライブラリっぽくなるんですが。<br />
          ないと思いますがプルリク等お待ちしております。
        `,
      },
      {
        id: 10001,
        title: "PySync",
        url: "https://github.com/Kate-AC/PySync",
        headline: "デプロイ用のPythonのコマンド。",
        description: `
          複雑なことは別にしておらず単なるrsyncコマンドのラッパーみたいな感じです。<br />
          VPN借りて掲示板を運営しているんですが、ソース上げるのがダルかったので学習がてら作りました。<br />
          全然README書いてないんですが、pysync.jsonに設定書いてコマンド叩くだけです。
        `,
      },
      {
        id: 10002,
        title: "youtube-api-go",
        url: "https://github.com/Kate-AC/youtube-api-go",
        headline: "YouTubeAPIを叩くためのGoのコマンド。",
        description: `
          唐突なケバブケース。<br />
          これも学習用なんですが、正解が良くわからず。<br />
          割と泥臭いコードになりがちだなーってのとinterface便利だなーって思いました。（小並感）<br />
        `,
      },
      {
        id: 10003,
        title: "docker-compose-php-nginx-mysql",
        url: "https://github.com/Kate-AC/docker-compose-php-nginx-mysql",
        headline: "Dockerfileとdocker-composeのサンプル。",
        description: `
          控えめに言ってゴミ。<br />
          docker-compose.ymlなんとなく書いたのでちゃんと調べて直したい。<br />
          最近だとhadolintで修正したりしてるのでこれもそのうち。
        `,
      },
    ];
  }

  render(): React.ReactElement {
    return (
      <>
        <LoadingPanel />
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
