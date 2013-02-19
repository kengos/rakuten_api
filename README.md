# RakutenApi

楽天ウェブサービス(http://webservice.rakuten.co.jp/) のAPIクライアントです。

以下のAPIに対応しています。

- [楽天商品検索API2](http://webservice.rakuten.co.jp/api/ichibaitemsearch/) (version:2012-07-23)
- [楽天ジャンル検索API2](https://webservice.rakuten.co.jp/api/ichibagenresearch/) (version:2012-07-23)
- [未実装] [楽天商品ランキングAPI2](https://webservice.rakuten.co.jp/api/ichibaitemranking/) (version:2012-09-27)

## Supported Ruby Interpreters

* MRI 1.9.3

## Installation

Add this line to your application's Gemfile:

    gem 'rakuten_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rakuten_api

## Usage

### 共通設定

どこでもいいので、以下を追加します。

Railsアプリケーション等の場合は、initializer等に登録してください。

```ruby
RakutenApi.configure do |config|
  config.application_id = "[applicationId]"
  config.affiliate_id = "[affiliateId]"
end
```

### 商品検索API 2

### 初期化

initilizerにブロックを渡せるようにしてあります。

```ruby
client = RakutenApi::ItemSearch::Client.new do |params|
  params.add_param :keyword, 'りんご'
  params.add_param :page, 2
end
```

また、`add_param`で渡すフィールドをRubyっぽい感じでも渡せるようになっています。

例) `genreId`を渡したい場合は`:genre_id`でもOK


### APIリクエスト

リクエストの方法は `get`と`request`の2種類があります。

* `get`

レスポンスを`Faraday::Response`として返します。

* `request`

レスポンスをある程度操作しやすいように、`RakutenApi::ItemSearch::Response`形式に変換して返します。


### RakutenApi::ItemSearch::Response

* ページ遷移機能

ページ遷移がしやすいように、`get_next_page`, `get_prev_page`を用意してあります。

それぞれの結果は、 `RakutenApi::ItemSearch::Response`として返ります。

* 単純なObjectマッピング

`simple_mapping`を呼び出すと、

[RakutenApi::ItemSearch::Model](https://github.com/kengos/rakuten_api/blob/master/lib/rakuten_api/item_search/model.rb) の配列で返却されます。


### ジャンル検索API 2

* genre_id: 0での検索

```ruby
client = RakutenApi::GenreSearch::Client.new do |params|
  params.add_param :genre_id, 0
end

response = client.request
p response.current
# => #<RakutenApi::GenreSearch::Model:0x007f956aba3fb8 @genre_id=0, @genre_name="", @genre_level=0>

p response.parents
# => []

p response.children
# => [
#  #<RakutenApi::GenreSearch::Model:0x007f956aba1ec0 @genre_id=211742, @genre_name="TV・オーディオ・カメラ", @genre_level=1>,
#  #<RakutenApi::GenreSearch::Model:0x007f956abcb360 @genre_id=100371, @genre_name="レディースファッション", @genre_level=1>,
#  ...
# ]
```

* genre_id: 551172での(genreLevel: 2)検索

```

client = RakutenApi::GenreSearch::Client.new do |params|
  params.add_param :genre_id, 551172
end

response = client.request
p response.current
# => <RakutenApi::GenreSearch::Model:0x007fe1a39a28b0 @genre_id=551172, @genre_name="医療計測器", @genre_level=2>

p response.parents
# => [#<RakutenApi::GenreSearch::Model:0x007fe1a39a2540 @genre_id=551169, @genre_name="医薬品・コンタクト・介護", @genre_level=1>]

p response.children
# => [
#  #<RakutenApi::GenreSearch::Model:0x007fe1a39a21a8 @genre_id=208232, @genre_name="塩素計", @genre_level=3>,
#  #<RakutenApi::GenreSearch::Model:0x007fe1a39a1fc8 @genre_id=551173, @genre_name="その他", @genre_level=3>,
#  ...
# ]
#
```

## Dependencies

* [faraday](https://github.com/lostisland/faraday)

### Development dependencies

* [rspec](https://github.com/rspec)
* [vcr](https://github.com/vcr/vcr)
* [webmock](https://github.com/bblimke/webmock)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
