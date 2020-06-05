User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# リレーションシップ
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# BBSスレッド
user = User.first
50.times do |n|
  title = "No.#{n} thread"
  content = "No.#{n} content"
  user.bbs_threads.create!(title: title, content: content)
end
user = User.second
title = "other user's thread"
content = "other user's content"
user.bbs_threads.create!(title: title, content: content)

# BBSスレッドへの書き込み
users = User.order(:created_at).take(2)
30.times do |n|
  content = "No.#{n} content"
  users.each do |user|
    BbsThread.first.user_posts.create!(content: content, user: user)
    BbsThread.first.anonymous_posts.create!(content: content, password: "foobar")
    BbsThread.second.user_posts.create!(content: content, user: user)
    BbsThread.second.anonymous_posts.create!(content: content, password: "foobar")
  end
end