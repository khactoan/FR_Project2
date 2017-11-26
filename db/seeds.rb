User.create! name: "Admin", email: "admin@gmail.com",
  password: "123456", password_confirmation: "123456",
  date_of_birth: "21/11/1996", is_admin: true

50.times do |n|
  name = "user-#{n+1}"
  email = "user-#{n+1}@gmail.com"
  password = "123456"
  User.create! name: name, email: email, password: password,
    password_confirmation: password, date_of_birth: "21/11/1996"
end

users = User.all
user = users.first
following = users[2..10]
followers = users[3..25]
following.each {|followed| user.follow followed}
followers.each {|follower| follower.follow user}
