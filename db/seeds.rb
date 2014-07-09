# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
test_users = Koala::Facebook::TestUsers.new(:app_id => FBHelper.app_id, :secret => FBHelper.app_secret)

# test_users.create_network(5, true, "email,user_friends")
# test_users.create_network(5, true, "email,user_friends")

test_user_base = test_users.list

user_counter = 1

test_user_base.each do |test_user_hash|
  graph = Koala::Facebook::API.new(test_user_hash['access_token'])
  test_user_profile_hash = graph.get_object("me")

  user_hash = {}
  user_hash[:username] = "test#{user_counter}"
  user_hash[:password] = 'apple123'
  user_hash[:password_confirmation] = 'apple123'
  user_hash[:first_name] = test_user_profile_hash['first_name']
  user_hash[:last_name] = test_user_profile_hash['last_name']
  user_hash[:facebook_id] = test_user_profile_hash['id']
  user_hash[:fb_access_token] = test_user_hash['access_token']
  user_hash[:small_image_url] = graph.get_connections('me', 'picture?redirect=false')['data']['url']
  user_hash[:large_image_url] = graph.get_connections('me', 'picture?redirect=false&type=large')['data']['url']

  User.create!(user_hash)

  user_counter += 1
end
