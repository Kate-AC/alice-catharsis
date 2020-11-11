import * as React from "react";
import LoadingPanel from "../../LoadingPanel";

export default function About(): React.ReactElement {
  return (
    <>
      <LoadingPanel nowLoading={false} />
      <div id="contents-body">
        <h1>ABOUT</h1>
        <p>HN: Kate</p>
        <p>Site: Alice Catharsis 少女カタルシス。</p>
        <h3>サイトについて</h3>
        <p>
          当サイトはポートフォリオ兼イラスト+ソースコードのポータルサイトです。
          <br />
          現代において単なる個人のホームページに価値は感じていないのですが、
          <br />
          自分のアウトプットをまとめた何かが欲しいと思い運営を続けています。
          <br />
          イラストを投稿するだけならピクシブやツイッターで事足りますし、
          <br />
          ソースコードを上げるならGitHubに上げていればいいのですが、
          <br />
          そうなってくると使っているSNSが分散してしまうため、
          <br />
          各SNSに対するポータルサイトとして運営していくことにしました。
        </p>
        <h3>リンクについて</h3>
        <p>
          当サイトへのリンク時のご連絡は不要です。
          <br />
          バナーは以下のものをお使い下さい。
          <br />
        </p>
        <p>
          <img
            src="https://s3-ap-northeast-1.amazonaws.com/s3.alice-catharsis/alice01.jpg"
            alt="banner"
          />
        </p>
        <h3>当サイトへのご連絡について</h3>
        <p>
          当サイトへのご連絡は下記のアドレス宛にお願い致します。
          <br />
          CONTACTにあるフォームから送っていただく事も可能です。
          <br />
        </p>
        <p>
          <img src="/images/mail.jpg" alt="mail" />
        </p>
        <h3>当サイトの情報</h3>
      </div>
    </>
  );
}
