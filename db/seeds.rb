User.create!(name: 'Alex',
             email: 'diffrencialx@gmail.com',
             password: '123456',
             password_confirmation: '123456',
             admin: true)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@mail.ru"
  password = '123456'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
