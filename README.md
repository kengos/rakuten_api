# RakutenApi

[![Build Status](https://travis-ci.org/kengos/rakuten_api.png?branch=master)](https://travis-ci.org/kengos/rakuten_api)

楽天ウェブサービス(http://webservice.rakuten.co.jp/) のAPIクライアントです。

以下のAPIに対応しています。

- [楽天商品検索API2](http://webservice.rakuten.co.jp/api/ichibaitemsearch/) (version:2012-07-23)
- [楽天ジャンル検索API2](https://webservice.rakuten.co.jp/api/ichibagenresearch/) (version:2012-07-23)
- [楽天商品ランキングAPI2](https://webservice.rakuten.co.jp/api/ichibaitemranking/) (version:2012-09-27)

## Supported Ruby Interpreters

* 1.9.3
* 2.0.0
* Rubinius 19mode

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

* keyword: 'りんご', hits: '2'(2商品だけ表示)での検索

```ruby
client = RakutenApi::GenreSearch::Client.new do |params|
  params.add_param :keyword, 'りんご'
  params.add_param :hits, 2
end

response = client.request

p response.status # => 200
p response.body # => APIのレスポンスBodyをJSONデコードした値が入っている
p response.page_count # => 100 (取得可能なページ数)(この場合は100まで指定可能を意味する)
p response.page # => 1 (現在のページ番号)
p response.carrier # => 0 (キャリア) (0: PC, 1: 携帯, 2: スマートフォン)
p response.first # => 1 (現在の表示商品始)(1つめを意味する)
p response.last # => 2 (現在の表示商品終)(2つめを意味する)
p response.simple_mapping
# => [
# #<RakutenApi::ItemSearch::Model:0x007fcb6cd6a350 @item_name="グルメ大賞2010 青森県産 りんご サンふじ...略", @catchcopy="【送料無料】りんご 青森産 サンふじ...略" @item_url="http://item.rakuten.co.jp/cameashi/10000323/", @affiliate_url="", @small_image_urls=["http://thumbnail.image.rakuten.co.jp/@0_mall/cameashi/cabinet/00473472/2012fuji-f5kgb.jpg?_ex=64x64", "http://thumbnail.image.rakuten.co.jp/@0_mall/cameashi/cabinet/00473472/img58491689.jpg?_ex=64x64", "http://thumbnail.image.rakuten.co.jp/@0_mall/cameashi/cabinet/00473472/img55339932.gif?_ex=64x64"], @medium_image_urls=["http://thumbnail.image.rakuten.co.jp/@0_mall/cameashi/cabinet/00473472/2012fuji-f5kgb.jpg?_ex=128x128", "http://thumbnail.image.rakuten.co.jp/@0_mall/cameashi/cabinet/00473472/img58491689.jpg?_ex=128x128", "http://thumbnail.image.rakuten.co.jp/@0_mall/cameashi/cabinet/00473472/img55339932.gif?_ex=128x128"], @image_flag=true, @availability=true, @tax_flag=false, @postage_flag=false, @creadit_card_flag=true, @shop_of_the_year_flag=false, @ship_overseas_flag=false, @asuraku_flag=false, @gift_flag=false, @ship_overseas_area="", @asuraku_closing_time="", @asuraku_area="", @affiliate_rate=1, @start_time="", @end_time="", @review_count=2371, @review_average=4.4, @point_rate=1, @point_rate_start_time="", @point_rate_end_time="", @shop_name="かめあし商店", @shop_code="cameashi", @shop_url="http://www.rakuten.co.jp/cameashi/", @genre_id="304637">
# ...
# ]
```

`simple_mapping`を呼び出すと、

[RakutenApi::ItemSearch::Model](https://github.com/kengos/rakuten_api/blob/master/lib/rakuten_api/item_search/model.rb) の配列で返却されます。


### add_param について

楽天WebService上で表記されている`genreId`を指定する場合

以下は全て同じパラメータを指定していることになる。

```ruby
params.add_param :genre_id, 0
params.add_param :genreId, 0
params.add_param 'genre_id', 0
params.add_param 'genreId', 0
```

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

```ruby
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

### 楽天商品ランキングAPI2

* 総合ランキング

```ruby
response = RakutenApi::ItemRanking::Client.new.request
p response.title # => '【楽天市場】ランキング市場 【総合】'
p response.last_build_date.class # => DateTime
p response.page # => 1
p response.simple_mapping
# => [
#  #<RakutenApi::ItemRanking::Model:0x007fa7c2138230 @rank=1, @carrier=0, @item_name="...>,
#  #<RakutenApi::ItemRanking::Model:...>,
#  ...
# ]
```

次のページを取得するには `next_ranking`を実行する。

使い方の詳細はexamplesを確認のこと。

[ranking_csv.rb](https://github.com/kengos/rakuten_api/blob/master/examples/ranking_csv.rb)

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
