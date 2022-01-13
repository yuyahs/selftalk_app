# Overview

* どういうサイトか：アウトプット特化の英語学習用サイト
* 何ができるか:
1. ランダムに表示される問題に英作文で回答する
2. 作成した回答の添削
3. オリジナルの単語帳作成
* アピールポイント: Rails × Vue3によるSPA化

# 使用技術

* Ruby 3.0.2
* Ruby on Rails 6.0,4
* MySQL 5.7
* Vue.js 3
* Docker
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

<img width="459" alt="selftalk_app_infra" src="https://user-images.githubusercontent.com/85814499/149320305-6d9dfb8e-c0c0-45eb-a19c-fe37edb9cba2.png">
