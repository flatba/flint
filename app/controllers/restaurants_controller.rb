class RestaurantsController < ApplicationController
  require 'net/http'
  require "open-uri"
  require 'nokogiri'
  require 'logger'

  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @restaurants = Restaurant.all
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
    # # スクレイピング先のURL
    restaurant_url = Restaurant.last.url

    # # charset = nil
    # # html = open(restaurant_url) do |f|
    # #   charset = f.charset # 文字種別を取得
    # #   f.read # htmlを読み込んで変数htmlに渡す
    # # end

    # # Heroku用にopen-uriの記述を追加
    # url_text = Net::HTTP.get(URI.parse restaurant_url)
    # doc = Nokogiri::HTML(url_text)

    # # htmlをパース(解析)してオブジェクトを生成
    # # doc = Nokogiri::HTML.parse(html, nil, charset)

    # # 店舗名
    # name =  doc.title
    # # カテゴリー
    # category = doc.xpath('//p/span[@property="v:category"][1]/text()').to_s
    # # 価格帯
    # price = doc.xpath('//dd[@class="rdhead-budget__price"]/a[@class]/text()').to_s
    # # price = price[1..price.index("～")-1].delete(",").to_i
    # # 評価
    # star = doc.xpath('//strong[@class="score"]/span/text()').to_s
    # # エリア
    # area = doc.xpath('//div[@class="parent"]/p/a[1]/text()').first
    # # イメージ
    # # image = doc.xpath('//meta[@property="og:image"]').attribute("content").value
    # # image = doc.xpath('//li[@class="mainphoto-box"]/img[@class="mainphoto-image"]').attribute("src").value



    # yelpのスクレイピング先のURL
    # url = 'https://www.yelp.co.jp/biz/%E3%83%8B%E3%83%A5%E3%83%BC%E3%83%A8%E3%83%BC%E3%82%AF-%E3%82%B0%E3%83%AA%E3%83%AB-%E6%96%B0%E5%AE%BF%E5%8C%BA'

    opt = {}
    opt['User-Agent'] = 'Opera/9.80 (Windows NT 5.1; U; ja) Presto/2.7.62 Version/11.01 '

    charset = nil
    html = open(url,opt) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end

    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, nil, charset)

    # 店舗名
    title =  doc.title
    puts title

    @restaurant.update(
      :name => name,
      # :category => category,
      # :price => price,
      # :star => star,
      # :area => area,
      # :image => image
      )

    redirect_to root_path
    
    else
      render 'new'
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
      if @restaurant.update(restaurant_params)
        
      else
        render 'edit'
      end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :category, :price, :star, :area, :image, :comment, :user_id, :payment, :url)
    end
end
