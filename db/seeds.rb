# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Answer.delete_all
Question.delete_all
User.delete_all

PASSWORD = '123456'

10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: PASSWORD
  )
end

200.times do
  created_at = Faker::Date.backward(365 * 5)

  # Faker is a module. We are accessing classes on the module
  # that will create fake data. No need to require the faker gem at the
  # top of this script because we can access all gems in the Gemfile
  # from anywhere.
  q = Question.create(
    title: Faker::Hacker.say_something_smart,
    body: Faker::ChuckNorris.fact,
    view_count: rand(100_000),
    created_at: created_at,
    updated_at: created_at,
  )
  if q.valid?
    q.answers = rand(0..15).times.map do
      Answer.new(body: Faker::GreekPhilosophers.quote)
    end
  end
end

puts Cowsay.say("Generated #{Question.count} questions", :koala)
puts Cowsay.say("Generated #{Answer.count} answers", :stegosaurus)
puts Cowsay.say("Generated #{User.count} answers", :ghostbusters)