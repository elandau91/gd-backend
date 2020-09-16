# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#name change test

require 'faker'

User.destroy_all
FaveShow.destroy_all

u1 = User.create(username: "elandau", password_digest: "pw", avatar: "img", email: "eli@gmail")
u2 = User.create(username: "chiara", password_digest: "pw", avatar: "img", email: "chiara@gmail")

fs1 = FaveShow.create(user_id: User.all.sample.id, show_id: "40cb4e0a-7c88-4f44-bf87-2596c174b699")
fs2 = FaveShow.create(user_id: User.all.sample.id, show_id: "40cb4e0a-7c88-4f44-bf87-2596c174b699")
fs3 = FaveShow.create(user_id: User.all.sample.id, show_id: "c690e235-c53d-4353-8bed-6c6a9a633054")

c1 = CommentShow.create(user_id: User.all.sample.id, show_id: "f2a3fc9e-0714-4f48-976c-e2a165dd147a", content: Faker::Music::GratefulDead.song)
c2 = CommentShow.create(user_id: User.all.sample.id, show_id: "f2a3fc9e-0714-4f48-976c-e2a165dd147a", content: Faker::Music::GratefulDead.song)

puts "done!"