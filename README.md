# agribaito

[KYUSHU BOOST 10000](https://kyushuboost.jp)で作成する農業バイトアプリ

## チームメンバー向けの説明
GitHubの使い方は[こちら](https://qiita.com/nnahito/items/565f8755e70c51532459)を参考にしてください．

### 最初は
1. まず，コマンドプロンプトを開きます．
2. 以下のコードでローカルにプロジェクトを保存します
```
cd desktop
git clone https://github.com/ykuchiki/agribaito.git
```

## ソースコードを書くときは
3. ソースコードを書き換える際は以下のようにブランチを作りましょう
```
git branch ブランチ名
```
4. 作成したブランチに移動します
```
git checkout ブランチ名
```

## 変更したソースコードをアップロード(プッシュ)しましょう
5. 変更したファイルをpushします
```
git add ファイル名.py
git commit -m "ここに変更した内容を一言書いてください
"git push origin branch名
```

以上です，お疲れまでした．

## その他
最新のmainブランチの内容をこまめに取得しましょう
```
git pull origin main
```

存在する枝を確認するとき
```
git branch
```