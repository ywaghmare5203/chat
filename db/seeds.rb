# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'yogesh@admin.com', password: '12345678', password_confirmation: '12345678', role: 3) if Rails.env.production?
AdminUser.create!(email: 'admin@admin.com', password: '12345678', password_confirmation: '12345678', role: 99) if Rails.env.production?


AdminUser.create!(email: 'yogesh@admin.com', password: '12345678', password_confirmation: '12345678', role: 3) if Rails.env.development?
AdminUser.create!(email: 'admin@admin.com', password: '12345678', password_confirmation: '12345678', role: 99) if Rails.env.development?

Role.create!(name: 'Buyer', status: true) if Rails.env.production?
Role.create!(name: 'Seller', status: true) if Rails.env.production?
Role.create!(name: 'Buyer',  status: true) if Rails.env.development?
Role.create!(name: 'Seller', status: true) if Rails.env.development?


Plan.create!(title: 'Monthly', description: 'Monthly Plan', amount: 33.99 , status:  true, duration: 30) if Rails.env.production?
Plan.create!(title: 'Quarterly', description: 'Quarterly Plan', amount: 79.99 , status:  true, duration: 90) if Rails.env.production?
Plan.create!(title: 'Yearly', description: 'Yearly Plan', amount: 699.99 , status:  true, duration: 90) if Rails.env.production?

Plan.create!(title: 'Monthly', description: 'Monthly Plan', amount: 33.99 , status:  true, duration: 30) if Rails.env.development?
Plan.create!(title: 'Quarterly', description: 'Quarterly Plan', amount: 79.99 , status:  true, duration: 90) if Rails.env.development?
Plan.create!(title: 'Yearly', description: 'Yearly Plan', amount: 699.99 , status:  true, duration: 90) if Rails.env.development?




#email : Mrunal.crescente@gmail.com

#pass:  VHrtz4"<\[Fv.3&D