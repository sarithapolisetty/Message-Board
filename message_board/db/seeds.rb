# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "admin"

Tagging.delete_all
Tag.delete_all
Like.delete_all
Reply.delete_all
Message.delete_all
User.delete_all

associate_user = User.create(
  first_name: "saritha",
  last_name: "polisetty",
  email: "sp@gmail.com",
  password: PASSWORD,
  admin: true
)

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end

users = User.all

20.times do
  Tag.create(
    name: Faker::Book.genre
  )
end

tags = Tag.all

puts Cowsay.say "Created #{tags.count} tags", :tux

20.times do
    m= Message.create({
        title: Faker::Hacker.noun,
        description: Faker::Hacker.say_something_smart,
        user: users.sample,
        tags: tags.shuffle.slice(0, rand(1..4))
    })
    if m.valid?
    rand(0..10).times do
      Reply.create(
        content: Faker::Matz.quote,
        message: m,
        user: users.sample
      )
    end
    m.likers = users.shuffle.slice(0, rand(users.count))
end
end

messages = Message.all
replies  = Reply.all
likes    = Like.all

puts Cowsay.say("Messaged #{messages.count} messages", :elephant)

puts Cowsay.say("Replied #{replies.count} replies", :dragon)

puts Cowsay.say "Created #{users.count} users", :ghostbusters

puts Cowsay.say("Created #{likes.count} likes", :frogs)

puts "Login with '#{associate_user.email}' and password of '#{PASSWORD}'"

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?