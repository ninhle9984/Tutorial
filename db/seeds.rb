User.create! name:  "Admin",
             email: "admin@admin.com",
             age: 22,
             gender: "male",
             password:              "123456",
             password_confirmation: "123456",
             admin: true

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
               password_confirmation: password
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
               password_confirmation: password
end
