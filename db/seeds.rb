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
40.times do |n|
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
10.times do |n|
  content = "No.#{n} content"
  bbs_thread1 = BbsThread.first
  bbs_thread2 = BbsThread.second
  users.each do |user|
    user_post1 = UserPost.new(content: content, user: user)
    bbs_thread1.push_post(user_post1)
    user_post2 = UserPost.new(content: content, user: user)
    bbs_thread2.push_post(user_post2)
    anonymous_post1 = AnonymousPost.new(content: content, password: "foobar")
    bbs_thread1.push_post(anonymous_post1)
    anonymous_post2 = AnonymousPost.new(content: content, password: "foobar")
    bbs_thread2.push_post(anonymous_post2)
  end
end

# Watch
user = User.first
Watch.new(user: user, bbs_thread: BbsThread.first).save
Watch.new(user: user, bbs_thread: BbsThread.second).save