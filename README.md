## アプリ概要
**Local's**は飲食店の情報を共有するアプリです。
自身が好きな飲食店の情報を投稿することができ、他者が投稿した内容を評価することができます。
基本的に携帯でもの使用を想定しているためレスポンシブ対応しています。

<img width="600" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/629084/74eb5b81-202c-7d40-ce31-c89efc3226f0.png">

※ mobile用UI
<img width="300" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/629084/2b22dce7-e9f0-8fef-5a08-c63c928d2721.png">

## 使用技術
+ Ruby '3.0.3'
+ Ruby on Rails '6.1.4'
+ RSpec '5.1.0'
+ Rubocop '1.25.1'
+ nuxt '2.15.8'
+ vuetify '2.6.1'
+ Jest '27.4.4'
+ ESLint '8.9.0'
+ AWS
    + ECR
    + ECS(Fargate)
    + RDS(MySQL '8.0')
    + Route53
+ Docker '20.10.12'
+ Docker-compose '1.29.1'
+ Terraform '1.0.0'
+ CircleCI '2.1'

## AWS構成図
<img width="600" alt="AWS構成図" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/629084/0d302d32-3384-7e15-e00b-7e0c02340ac8.png">

### 工夫した点
1. CircleCIを使用して自動でRspec, Rubocop, Jest, ESLintを実行できるようにしている。
1. PrivateLintを使用することでECR、SSM、S3とAWSのサービス間の通信をインターネットを介さずに通信を可能にしている。
1. 極力インスタンスをプライベートサブネットに配置することで不要なアクセスを減らしている。

## ER図
<img width="600"　alt="ER図" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/629084/445ea1e0-601c-ccf1-1a17-431e44ad906a.png">

## 機能一覧
|機能|仕様|
|:--:|:--:|
|サインアップ、ログイン、サインアウト機能|devise_token_authのトークン認証でサインアップ、ログイン、サインアウトできる|
|パスワード変更機能|パスワードとパスワード確認を入力すると編集ができる|
|プロフィール編集機能|ユーザー名、プロフィール画像、自己紹介、メールアドレスの変更ができる|
|フォロー、アンフォロー機能|各ユーザーをフォロー、アンフォローができる|
|投稿機能|店名、最寄り駅、写真、コメント、カテゴリーの投稿作成、削除ができる|
|画像投稿機能|RailsのActiveStorageを使って複数画像の投稿ができる|
|画像拡大機能|写真をクリックすると拡大されて表示|
|画像スクロール機能|swiperを用いて画像をスライドして閲覧可能|
|ユーザー削除機能|ユーザーの削除ができる|
|カテゴリー検索機能|投稿をカテゴリー別で検索ができる|
|ブックマーク機能|自分以外のユーザーの投稿をブックマークできる|
|いいね機能|自分以外のユーザーの投稿に「また行きたい！」というプラスの評価ができる|
|悪いね機能|自分以外のユーザーの投稿に「う〜ん」というマイナスの評価ができる|
|グラフ表示機能|vue-chartjsを用いて投稿に対して評価したユーザーの年代別いいね率を表示|
|GoogleMap表示機能|投稿の店名、最寄り駅からお店の位置をGoogleMapで表示|


## 今後実装しようと思うこと
3. いいねのランキング表示
3. ユーザー別使用カテゴリー比率表示
4. デザインの修正
5. 投稿編集機能
6. 管理者権限
6. フロントエンドのTypeScript化

