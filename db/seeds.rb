User.create! name:  "Admin",
             email: "admin@admin.com",
             age: 22,
             gender: "male",
             password:              "123456",
             password_confirmation: "123456",
             admin: true,
             activated: true,
             activated_at: Time.zone.now

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  age = n < 18 ? 18 + n : n +1
  gender = "male"
  User.create! name:  name,
               email: email,
               age: age,
               gender: gender,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now
end

51.upto(90) do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  age = n + 1
  gender = "female"
  User.create! name:  name,
               email: email,
               age: age,
               gender: gender,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now
end

users = User.order(:created_at).take 8
60.times do
  content = Faker::Lorem.sentence 5
  users.each do |user|
    user.microposts.create!(content: content)
  end
end

users = User.all
user= users.first
following = users[0..50]
followers = users[3..45]

following.each do |followed|
  user.follow followed
end

followers.each do |follower|
  follower.follow user
end
