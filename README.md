# chatwork_soracom

## 概要
chatwork から soracom の CLI を実行するボット。

## 使い方
hubot の実行スクリプトを forever 使ってデーモン化してるので、そのまま実行スクリプト使うならforever をインストールしてください。
```
$ sudo npm install forever -g
```

### bin/run_hubot

以下２つの環境変数については、各自の環境に合わせて設定してください。
```
export HUBOT_CHATWORK_TOKEN="Chatwork API token"
export HUBOT_CHATWORK_ROOMS="Chatwork Room ID fot post message"
```

### scripts/chatbot.coffee

simIsmi に操作する SIM の imsi をセットしてください。  
気が向いたら引数で受け取ったり、複数セットしたり出来るようにします(๑•̀ㅂ•́)و✧
```
# sim imsi
# [todo]
# pass by arguments
simImsi = 'xxxxxxxxxxxxxxx'
```
## つかえる命令

### いちらんちょうだい
imsi の一覧を取得します
```
soracom subscriber list
```

### うごけぇぇぇぇ
設定している SIM をアクティベートします
```
soracom subscriber activate --imsi=xxxx
```
### とまれーーーー
設定している SIM をディアクティベートします
```
soracom subscriber deactivate --imsi=xxx
```

### ヘイスト
設定している SIM の通信速度を「s1.fast」にします
```
soracom subscriber update_speed_class --imsi=xxxx --speed-class=s1.fast
```

### スロウ
設定している SIM の通信速度を「s1.minimum」にします
```
soracom subscriber update_speed_class --imsi=xxxx --speed-class=s1.minimum
```
