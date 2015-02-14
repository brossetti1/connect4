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

60.times do
  Player.create()


30.times do
  Game.create(
    current_player_id: random_player,
    winner_id: random_player,
    ##### make this the default value for state ####
    state: { 0 => [0,1,2,3,4,5],
             1 => [0,1,2,3,4,5],
             2 => [0,1,2,3,4,5],
             3 => [0,1,2,3,4,5],
             4 => [0,1,2,3,4,5],
             5 => [0,1,2,3,4,5],
             6 => [0,1,2,3,4,5] })
end







