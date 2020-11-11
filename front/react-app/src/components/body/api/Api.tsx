import * as React from "react";
import LoadingPanel from "../../LoadingPanel";

export default function Api(): React.ReactElement {
  return (
    <>
      <LoadingPanel nowLoading={false} />
      <div id="contents-body">
        <h1>API</h1>
        <p>
          当サイトでは試験的にAPIを公開しています。
          <br />
          サーバーにかかる負荷が著しい場合は、断りなく公開を中止またはIPによる制限行う可能性があります。
        </p>
        <h3>1. getLastImage</h3>
        <p>このAPIは最新の画像を取得します。</p>

        <h4>・パラメータ</h4>

        <p>【target_type】</p>
        <p>
          all: 全ての画像から取得する。(デフォルト)
          <br />
          normal: 全年齢向けの画像から取得する。
          <br />
          r18: R18の画像から取得する。
        </p>

        <p>【limit】</p>
        <p>1〜5まで指定可能（デフォルト5）</p>

        <h4>・戻り値</h4>
        <div className="code-background">
          <pre>
            {`
  [
    {
      id: 999
      title: なにかの絵,
      url: https://twitter.com/hogefuga,
      thumbnail: https://pbs.twimg.com/media/hogefuga
      target_type: "normal"
    }
  ]
          `}
          </pre>
        </div>

        <h4>・使用例</h4>
        <div className="code-background">
          <pre>
            {`
  https://api.alice-catharsis.com/v1/images/latest （?target_type=all&limit=5と同様の結果）
  https://api.alice-catharsis.com/v1/images/latest?target_type=all&limit=5
          `}
          </pre>
        </div>
      </div>
    </>
  );
}
