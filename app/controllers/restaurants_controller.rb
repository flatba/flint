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
    # @restaurant = Restaurant.all
    # @restaurant = Restaurant.find(2)
    # @restaurant = Restaurant.where(:user_id => current_user.id)
    @restaurant = Restaurant.find(current_user.id)
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
    # スクレイピング先のURL
    restaurant_url = Restaurant.last.url

    ######################################################################
    # yelp
    ######################################################################
    # # image = doc.xpath('//li[@class="mainphoto-box"]/img[@class="mainphoto-image"]').attribute("src").value

    url = Restaurant.last.url

    # スマホURLの対応
    if (restaurant_url.index("m") == 8)
      url = url.gsub("m", "www")
    end

    opt = {}
    opt['User-Agent'] = 'Opera/9.80 (Windows NT 5.1; U; ja) Presto/2.7.62 Version/11.01 '

    charset = nil

    html = open(restaurant_url,opt) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end

    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, nil, charset)

    # 店舗名
    title =  doc.title
    title_num =  doc.title.index("-")
    title = title[0..title_num-2]
    puts title

    # # カテゴリー
    category = doc.xpath('//span[@class="category-str-list"]/a[1]/text()').to_s
    # category2 = doc.xpath('//span[@class="category-str-list"]/a[2]/text()').to_s
    # category3 = doc.xpath('//span[@class="category-str-list"]/a[3]/text()').to_s
    # puts category1
    # puts category2
    # puts category3
    # 価格帯
    price = doc.xpath('//dd[@class="nowrap price-description"]/text()').to_s
    price_head = price.index("￥")

    if price.count("以") > 0
      price_tail = price.index("以上")
    elsif price.count("-") > 0
      price_tail = price.index("-")
    elsif
      price_tail = nil
    end

    if price_tail != nil
      price = price[price_head+1..price_tail-1].delete(",").to_i
    end

    puts price

    # 評価
    star = doc.xpath('//i[@class="star-img stars_4"]').attribute("title").value
    star_num = star.index("星")
    star = star[0..star_num-2]
    puts star
    # エリア
    area = doc.xpath('//span[@class="neighborhood-str-list"]/text()')
    area.index("n")
    puts area
    # イメージ
    image = doc.xpath('//meta[@property="og:image"]').attribute("content").value
    image_url = doc.xpath('//a[@class="see-more show-all-overlay"]').attribute("href").value
    image_url = "https://www.yelp.co.jp/" + image_url + "?tab=food"

    html = open(image_url,opt) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, nil, charset)
    image = doc.xpath('//meta[@property="og:image"]').attribute("content").value

    ######################################################################

    @restaurant.update(
      :name => title,
      :category => category,
      :price => price,
      :star => star,
      :area => area,
      :image => image
      )

    redirect_to root_path

    else
      render 'new'
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update

    # パラメータから取得したURLにアクセスしようとしてもレストラン情報の上書きができない（通常ではできる）
    # 問題は、URLにアクセスしたときに起こっている。

    url = restaurant_params[:url]
    comment = restaurant_params[:comment]
    user_id = restaurant_params[:user_id]
    payment = restaurant_params[:payment]

    logger.debug(url)

    # スマホURLの対応
    if (url.index("m") == 8)
      url = url.gsub("m", "www")
    end

    logger.debug"1"

    # ここでアクセスできなくて止まる。

    charset = nil
    html = open(restaurant_url,opt) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end

    logger.debug"2"

    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, nil, charset)

    logger.debug"3"

    # 店舗名
    title =  doc.title
    title_num =  doc.title.index("-")
    title = title[0..title_num-2]
    puts title

    # # カテゴリー
    category = doc.xpath('//span[@class="category-str-list"]/a[1]/text()').to_s
    # category2 = doc.xpath('//span[@class="category-str-list"]/a[2]/text()').to_s
    # category3 = doc.xpath('//span[@class="category-str-list"]/a[3]/text()').to_s
    # puts category1
    # puts category2
    # puts category3
    # 価格帯
    price = doc.xpath('//dd[@class="nowrap price-description"]/text()').to_s
    price_head = price.index("￥")

    if price.count("以") > 0
      price_tail = price.index("以上")
    elsif price.count("-") > 0
      price_tail = price.index("-")
    elsif
      price_tail = nil
    end

    if price_tail != nil
      price = price[price_head+1..price_tail-1].delete(",").to_i
    end

    puts price

    # 評価
    star = doc.xpath('//i[@class="star-img stars_4"]').attribute("title").value
    star_num = star.index("星")
    star = star[0..star_num-2]
    puts star
    # エリア
    area = doc.xpath('//span[@class="neighborhood-str-list"]/text()')
    area.index("n")
    puts area
    # イメージ
    image = doc.xpath('//meta[@property="og:image"]').attribute("content").value
    image_url = doc.xpath('//a[@class="see-more show-all-overlay"]').attribute("href").value
    image_url = "https://www.yelp.co.jp/" + image_url + "?tab=food"

    html = open(image_url,opt) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, nil, charset)
    image = doc.xpath('//meta[@property="og:image"]').attribute("content").value

    ######################################################################
    @restaurant.update_all(
      :name => title,
      :category => category,
      :price => price,
      :star => star,
      :area => area,
      :image => image,
      :comment => comment,
      :payment => payment,
      :url => url,
    )
    redirect_to root_path
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
      # @restaurant = Restaurant.find(params[:id])
      @restaurant = Restaurant.where(:user => current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :category, :price, :star, :area, :image, :comment, :user_id, :payment, :url)
    end
end
