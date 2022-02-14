# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

arr = [
  'HTML',
  'CSS',
  'Ruby',
  'Ruby On Rails',
  'JavaScript',
  'Vue',
  'サーバー',
  'セキュリティー',
  'ネットワーク',
  'Docker',
  '基礎知識',
  'その他'
];

arr.size.times do |i|
  Category.create([
    'name' => arr[i],
    'created_at' => Time.now,
    'updated_at' => Time.now
  ]);
end

20.times do
User.create([
  'name' => Faker::Name.unique.name,
  'email' => Faker::Internet.unique.email,
  'password' => 'password'
]);
end

250.times do
Post.create([
  'title' => Faker::Movie.title,
  'question' => Faker::Quote.famous_last_words,
  'answer' => Faker::Quote.matz,
  'user_id' => rand(1..21),
  'category_id' => rand(1..12)
]);
end
