class Restaurant < ActiveRecord::Base
	belongs_to :user
  	has_many :user_likes

  # validates :comment, presence: true, length: { maximum: 50 } # 50文字まで

# require 'net/http'
# require "open-uri"
# require "nokogiri"

# 食べログのページを保存する

# 食べログページのhtmlを保存する

# 食べログページのnokogiriをかます


# スクレイピング先のURL
# Tabelog_mainpage = "http://tabelog.com/"
# htmlをパース(解析)してオブジェクトを生成

# htmlをパース(解析)してオブジェクトを生成

end
