
# 10.times do
# 	User.create(
# 	  	# :id => Faker::Number.between(1, 100),
# 	  	:email => Faker::Internet.email, 
# 	  	:encrypted_password => "testtest",
# 	  	# :reset_password_token => nil,
# 	  	# :reset_password_sent_at => nil,
# 	  	# :remember_created_at => nil,
# 	  	:sign_in_count => 1,
# 	  	# :current_sign_in_at => "2016-04-26 02:43:49",
# 	  	# :last_sign_in_at => "2016-04-26 02:43:49",
# 	  	# :current_sign_in_ip => "::1",
# 	  	# :last_sign_in_ip => "::1",
# 	  	:name => Faker::Name.name,
# 	  	:gender => FFaker::Gender.random,
# 	  	:age_range => Faker::Number.between(20, 40),
# 	  	:thumb => Faker::Avatar.image,
# 	  	:password => "testtest",
# 	  	:uid => Faker::Number.number(17),
# 	  	# :provider => "facebook",
# 	  	:created_at => "2016-04-26 02:43:49",
# 	  	:updated_at => "2016-04-26 02:43:49"
# 	)

# 	UserLike.create(
# 		# :id => Faker::Number.between(2, 100),
# 		:user_id => Faker::Number.between(1, 10),
# 		:like_id => Faker::Number.between(1, 10),
# 		:matching => 3,
# 		:created_at => "2016-04-26 02:43:49", 
# 		:updated_at => "2016-04-26 02:43:49",
# 		:restaurant_id => Faker::Number.between(1, 100)
# 	)

# 	Restaurant.create(
# 	  	# :id => Faker::Number.between(1, 100),
# 	  	:name => "A店", 
# 	  	:category => "居酒屋",
# 	  	:price => Faker::Number.between(5000, 50000),
# 	  	:star => Faker::Number.between(1, 5),
# 	  	:area => "新宿",
# 	  	:image => "https://placehold.jp/150x150.png",
# 	  	:comment => FFaker::HipsterIpsum.phrase,
# 	  	:user_id => Faker::Number.between(1, 100),
# 	  	:payment => Faker::Number.between(0, 1),
# 	  	:url => nil
# 	  # 	created_at: => "2016-04-26 02:43:49"
# 	  # 	updated_at: => "2016-04-26 02:43:49"
# 	)
# end

require "csv"

CSV.foreach('db/csv/user.csv') do |row|
  User.create(
  	:email => row[0],
  	:encrypted_password => row[1],
  	:sign_in_count => row[2],
  	:name => row[3],
  	:gender => row[4],
  	:age_range => row[5],
  	:thumb => row[6],
  	:password => row[7],
  	:uid => row[8],
  	:created_at => row[9],
	:updated_at => row[10]
  	)
end

CSV.foreach('db/csv/user_like.csv') do |row|
  UserLike.create(
  	:user_id => row[0],
	:like_id => row[1],
	:matching => row[2],
  :restaurant_id => row[3],	
	:created_at => row[4],
	:updated_at => row[5]
  	)
end

CSV.foreach('db/csv/restaurant.csv') do |row|
  Restaurant.create(
  	:name => row[0],
	:category => row[1],
	:price => row[2],
	:star => row[3],
	:area => row[4],
	:image => row[5],
	:comment => row[6],
	:user_id => row[7],
	:payment => row[8],
	:url => row[9],
	:created_at => row[9],
	:updated_at => row[10],
  	)
end











