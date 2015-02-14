# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

30.times do 
 User.create(
  username: Faker::Internet.user_name,
  email: Faker::Internet.email,
  password: 'password',
  wins: rand(100),
  losses: rand(100),
  ties: rand(30))
end

User.all.each do |user|
  UserProfile.create(user_id: user.id)
end

UserProfile.all.each do |profile|
  profile.first_name = Faker::Name.first_name, 
  profile.last_name = Faker::Name.last_name, 
  profile.country = Faker::Address.country,
  profile.bitcoin_address = Faker::Bitcoin.address,
  profile.card_type = Faker::Business.credit_card_type,
  profile.expirey_date = Faker::Business.credit_card_expiry_date,
  profile.card_number_last_four = Faker::Business.credit_card_number[-4..-1],
  profile.favorite_color = Faker::Commerce.color,
  profile.blog = Faker::Internet.url,
  profile.save
end

def random_player
  User.find(User.pluck(:id).sample)
end


70.times do |x|
  player1 = random_player
  player2 = random_player
  game = Game.new()
  game.users = [player1, player2]
  game.save
  x.even? ? game.winner_id = player1.id : game.winner_id = player2.id
end

Game.all.each do |game|
  game.current_player_id = game.winner_id
end




