# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Question.delete_all

200.times do
  created_at = Faker::Date.backward(365 * 5)

  # Faker is a module. We are accessing classes on the module
  # that will create fake data. No need to require the faker gem at the
  # top of this script because we can access all gems in the Gemfile
  # from anywhere.
  Question.create(
    title: Faker::Hacker.say_something_smart,
    body: Faker::ChuckNorris.fact,
    view_count: rand(100_000),
    created_at: created_at,
    updated_at: created_at,
  )
end

puts Cowsay.say("Generated #{Question.count} questions", :koala)