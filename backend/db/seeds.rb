require 'faker'
# ゲストユーザーのサンプルデータ
User.create!(
  name: 'guest',
  email: 'guest@example.com',
  birth_place: '北海道',
  birth_year: 2000,
  birth_month: 1,
  birth_day: 1,
  gender: 'woman',
  introduction: 'guestの自己紹介です。',
  password: 'password',
  password_confirmation: 'password'
)
# user = User.find(1)
# user.avatar.attach(io: File.open('app/assets/images/avatar1.jpeg'), filename: 'avatar1.jpeg')

# 50人のuserサンプルデータ作成
50.times do |n|
  User.create!(
    name: "user#{n}",
    email: Faker::Internet.unique.email,
    birth_place: '東京都',
    birth_year: Faker::Number.between(from: 1920, to: 2021),
    birth_month: Faker::Number.between(from: 1, to: 12),
    birth_day: Faker::Number.between(from: 1, to: 30),
    gender: 'man',
    password: 'password',
    password_confirmation: 'password'
  )
end

# user2 = User.find(2)
# user2.avatar.attach(io: File.open('app/assets/images/avatar2.jpeg'), filename: 'avatar2.jpeg')
# user3 = User.find(3)
# user3.avatar.attach(io: File.open('app/assets/images/avatar3.jpeg'), filename: 'avatar3.jpeg')
# user4 = User.find(4)
# user4.avatar.attach(io: File.open('app/assets/images/avatar4.jpg'), filename: 'avatar4.jpg')
# User.all[4..49].each do |user|
#   user.avatar.attach(io: File.open('app/assets/images/avatar1.jpeg'), filename: 'avatar1.jpeg')
# end

# カテゴリーのデータ作成
# category_list = [
#   'ラーメン',
#   '焼肉',
#   'イタリアン',
#   'ピザ',
#   'そば',
#   'うどん',
#   'ステーキ',
#   'ハンバーグ',
#   '定食',
#   'パスタ',
#   '寿司',
#   '焼き鳥',
#   'ハンバーガー',
#   '中華',
#   '洋食',
#   'お好み焼き',
#   '天ぷら',
#   '串揚げ',
#   '居酒屋',
#   'バー',
#   'もんじゃ焼き',
#   'とんかつ',
#   '丼',
#   'カレー',
#   'スープカレー',
#   'モツ鍋',
#   'ジンギスカン',
#   'その他'
# ]
# category_list.each{ |category| Category.create!(
#   name: category
#   )
# }

# 投稿サンプルデータ
# image_meet_group = [
#   'meet1.jpg',
#   'meet2.jpg',
#   'meet3.jpg',
#   'meet4.jpg',
#   'meet5.jpg',
#   'meet6.jpg',
#   'meet7.jpg',
#   'meet8.jpg'
# ]
# image_pasta_group = [
#   'pasta1.jpg',
#   'pasta2.jpg',
#   'pasta3.jpg'
# ]
# image_chiken_group = [
#   'chiken1.jpg',
#   'chiken2.jpg',
#   'chiken3.jpg',
#   'chiken4.jpg',
#   'chiken5.jpg'
# ]
post1 = Post.new({
  restaurant_name: '牛角　武蔵浦和店',
  comment: '王様ハラミが柔らかくて美味しい!店長さんの接客も非常に良く、大満足です',
  station: '武蔵浦和',
  # category_ids: [2],
  user_id: 1
})
post2 = Post.new({
  restaurant_name: '新時代　渋谷道玄坂店',
  comment: '名物の伝串は1本50円でとても美味しかったです。ぜひまた行きたいです!',
  station: '渋谷',
  # category_ids: [12, 19],
  user_id: 2
})
post3 = Post.new({
  restaurant_name: '串鳥　琴似店',
  comment: '基本的に焼鳥屋さんなので居酒屋さんほどメニューの種類は多くはありませんが、どの料理も安くて美味しいと思います。',
  station: '琴似駅',
  # category_ids: [2, 19],
  user_id: 3
})
post4 = Post.new({
  restaurant_name: '五右衛門　新発寒店',
  comment: 'どのパスタを食べてもはずれはありません！ぜひ食べに行ってみってください。',
  station: '発寒駅',
  # category_ids: [3, 10],
  user_id: 4
})
# image_meet_group.each do |image|
#   post1.images.attach(io: File.open("app/assets/images/#{image}"), filename: image)
# end
# image_chiken_group.each do |image|
#   post2.images.attach(io: File.open("app/assets/images/#{image}"), filename: image)
# end
# image_chiken_group.each do |image|
#   post3.images.attach(io: File.open("app/assets/images/#{image}"), filename: image)
# end
# image_pasta_group.each do |image|
#   post4.images.attach(io: File.open("app/assets/images/#{image}"), filename: image)
# end

posts = [post1, post2, post3, post4]

posts.each do |post|
  post.save!
end

# リレーションシップ作成
users = User.all
user = users.first
following = users[2..13]
followers = users[8..20]
following.each{ |followed| user.follow(followed) }
followers.each{ |follower| follower.follow(user) }

# like, dislike作成
# users_group_1 = User.all[1..14]
# users_group_2 = User.all[15..29]
# users_group_3 = User.all[30..44]
# users_group_4 = User.all[45..49]
# posts = Post.all
# users_group_1.each do |user|
#   user.like(posts[0])
# end
# users_group_2.each do |user|
#   user.like(posts[1])
# end
# users_group_3.each do |user|
#   user.like(posts[2])
# end
# users_group_4.each do |user|
#   user.like(posts[3])
# end
# users_group_1.each do |user|
#   user.dislike(posts[3])
# end
# users_group_2.each do |user|
#   user.dislike(posts[2])
# end
# users_group_3.each do |user|
#   user.dislike(posts[1])
# end
# users_group_4.each do |user|
#   user.dislike(posts[0])
# end
