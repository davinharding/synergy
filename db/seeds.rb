# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

[
  "Lifting",
  "Cycling",
  "Swimming",
  "Running",
  "Tennis",
  "Basketball",
  "Soccer",
  "Rowing"
].each do |activity|
  Activity.find_or_create_by(activity: activity)
end

n = 1

100.times do
  user = User.create(
    email: Faker::Internet.free_email,
    password: "asdfasdf",
  )
  Profile.find_or_create_by(
    name: Faker::Name.first_name,
    age: (13..65).to_a.sample,
    user_id: n
  )
  n += 1
end

  # [
#   "andy@gmail.com",
#   "davin@gmail.com",
#   "rumen@gmail.com"
# ].each do |email|
#   User.create!(email: email, password: "password") unless User.find_by(email: email)
# end

User.all.each do |user|
  Activity.all.each do |activity|
    UserActivity.find_or_create_by(user: user, activity: activity) if [true, false].sample
  end
end