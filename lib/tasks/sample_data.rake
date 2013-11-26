namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    user = User.create!(username: "Example_User",
                 email: "example@blocipedia.com",
                 password: "helloworld",
                 password_confirmation: "helloworld")
    user.skip_confirmation!
    user.save
    10.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@blocipedia.com"
      password = "password"
      u = User.create!(username: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
      u.skip_confirmation!
      u.save
    end

    users = User.all(limit: 5)
    5.times do
      title = Faker::Lorem.words(rand(1..10)).join(" ")
      body = Faker::Lorem.sentence(30)
      users.each { |user| user.wikis.create!(title: title, body: body) }
    end
  end
end