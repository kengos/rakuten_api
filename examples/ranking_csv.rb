# coding: utf-8
# 楽天ランキングAPIを利用し、ランキングデータをCSVとして保存するサンプル
# config.item_ranking_module = 'MyCSV' の使い方を説明したかっただけ

require 'rakuten_api'
require 'faraday'
require 'csv'

module MyCSV
  CSV_KEYS = {
    rank: "ランク",
    shop_name: "店舗名",
    shop_url: "店舗URL",
    item_name: "商品名",
    catchcopy: "キャッチコピー",
    item_price: "価格",
    medium_image_urls: "画像",
    tax_flag: "消費税",
    postage_flag: "送料",
    review_count: "レビュー数",
    review_average: "平均レビュー",
  }.freeze

  def to_a
    row = []
    h = to_hash
    CSV_KEYS.keys.each do |key|
      row << h[key]
    end
    row.map do |o|
      o.is_a?(Array) ? o.first : o
    end
  end
end

RakutenApi.configure do |config|
  config.application_id = "[Your Application Id]"
  config.item_ranking_module = 'MyCSV'
end


client = RakutenApi::ItemRanking::Client.new
response = client.request

CSV.open(response.last_build_date.strftime('%Y%m%d%H%M') + '.csv', "wb", { col_sep: ',', row_sep: "\n", force_quotes: true }) do |csv|
  csv << RakutenApi::ItemRanking::Model::CSV_KEYS.values
  begin
    response.simple_mapping.each do |f|
      csv << f.to_a
    end
    sleep 1
    response = response.next_ranking
  end while response.success?
end