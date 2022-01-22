# Overview

* アウトプット力を養うための英語学習用サービスです。
* ランダムに出題される問題に対して英作文で回答し、回答は振り返り・添削可能です。
* 毎日継続するモチベーション維持のため学習状況が見える化されています。

# 使用技術

* Ruby 3.0.2
* Ruby on Rails 6.0,4
* MySQL 5.7
* Vue.js 3（SPA化）
* Docker
* CircleCi CI/CD
* Nginx
* Unicorn
* AWS:  VPC  EC2  RDS  Route53  ELB
* Capistrano3
* RSpec

# 機能一覧

* ユーザー登録（メール認証）、ログイン機能
* ゲストログイン機能
* お知らせ通知機能
* 問題出題機能、回答機能
* 回答添削機能
* 単語帳作成機能
* 総合学習日数表示機能
* 連続学習日数表示機能
* 一週間の学習コミット表示機能(GitHubでいう草)
* 管理ユーザー用機能
1. 出題文一覧表示機能
2. 出題文作成機能
3. お知らせ発行機能
4. ユーザー数・ユーザー一覧表示機能

# テスト

* RSpec
1. 単体テスト（model)
2. 機能テスト（request)

# インフラ図

<img width="622" alt="スクリーンショット 2022-01-22 13 19 33" src="https://user-images.githubusercontent.com/85814499/150624415-a2c99530-6943-46a1-8fef-000b42589afd.png">


# CircleCi CI/CD
* Githubへのpush時に、RSpecとRubocopが自動で実行されます。
* masterブランチへのpushでは、RSpecとRubocopが成功した後に、EC2への
自動デプロイが実行されます。
