class Restaurant < ActiveRecord::Base
    belongs_to :user
    has_many :user_likes

    # validates :comment, presence: true, length: { maximum: 50 } # 50文字まで
    # require 'net/http'
    # require "open-uri"
    # require "nokogiri"

    validates :url, :comment, presence: true

end
