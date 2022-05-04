# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
    name: "admin",
    email: "admin@admin.com",
    password: "123456",
    is_admin: true
)
user = User.create!(
    name: "tomo",
    email: "tomo@gmail.com",
    password: "123456",
    is_admin: false
)
Task.create!(
    name: "task",
    content: "do a thing",
    deadline: "2021-10-12",
    priority: 2,
    status: "unstarted",
    user_id: user.id
)
Task.create!(
    name: "new task",
    content: "do a new thing",
    deadline: "2021-10-15",
    priority: 1,
    status: "in progress",
    user_id: user.id
)