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
    user_id: n,
    street: [
      '2727 NW 2nd Ave',
      '251 NW 25th ST',
      '2550 NW 2nd Ave',
      '2506 NW 2nd Ave',
      '223 NW 23rd ST',
      '2750 NW 3rd Ave',
      '2700 N Miami Ave',
      '2230 NW 2nd Ave',
      '2637 N Miami Ave',
      '28 NE 29th ST',
      '2300 NW 2nd Ave',
      '2506 NW 2nd Ave',
      '2300 NW 2nd Ave',
      '5837 Sunset Dr',
      '5887 SW 73rd ST',
      '5800 SW 73rd ST',
      '5812 Sunset Dr',
      '7301 SW 57th CT',
      '278 Miracle Mile',
      '339 Miracle Mile',
      '201 Miracle Mile',
      '7535 N Kendall Dr',
      '7491 SW 88th ST',
      '9533 S Dixie Hwy',
      '9200 S Dixie Hwy',
      '11 Washington Ave',
      '1 Washington Ave',
      '600 Lincoln Road',
      '915 Lincoln Road',
      '4525 Collins Ave',
      '1701 Collins Ave',
      '4441 Collins Ave',
      '690 Lincoln Road',
      '1445 Washington Ave',
      '743 Washington Ave',
      '136 Collins Ave',
      '1424 20th st',
      '1424 Alton Rd',
      '1300 S Miami Ave',
      '49 SW 11th ST',
      '901 S Miami Ave',
      '777 Brickell Ave',
      '15 SE 10th ST',
      '900 S Miami Ave',
      '947 Brickell Ave',
      '444 Brickell Ave',
      '34 SW 13th ST',
      '931 Brickell Ave',
      '1111 SW 1st Ave',
      '1250 S Miami Ave',
      '1320 S Dixie Hwy',
      '1100 S Dixie Hwy',
      '360 NW 8th ST',
      '901 SW 8th ST',
      '1642 SW 8th ST',
      '1277 SW 8th ST',
      '401 Biscayne Blvd',
      '244 Biscayne Blvd',
      '601 Biscayne Blvd',
      '1601 Biscayne Blvd',
      '2929 Biscayne Blvd',
      '2501 Biscayne Blvd',
      '1103 Biscayne Blvd',
      '2419 Biscayne Blvd',
      '3595 Biscayne Blvd',
      '1700 Biscayne Blvd'
    ].sample,
    city: "Miami",
    state: "Florida",
    bio: [
      Faker::SiliconValley.quote,
      Faker::MichaelScott.quote,
      Faker::HarryPotter.quote
  ].sample
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

