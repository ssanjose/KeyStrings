require "csv"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.delete_all
User.delete_all
Item.delete_all
Province.delete_all
Category.delete_all

# Load provinces
filename = Rails.root.join("db/provinces.csv")
puts "Loading Provinces from the csv file: #{filename}"
csv_data = File.read(filename)
provinces = CSV.parse(csv_data, headers: true, encoding: "utf-8")
provinces.each do |m|
  Province.create(
    title: m["title"],
    pst:   m["pst"],
    gst:   m["gst"]
  )
end

# Load categories
filename = Rails.root.join("db/categories.csv")
puts "Loading Categories from the csv file: #{filename}"
csv_data = File.read(filename)
categories = CSV.parse(csv_data, headers: true, encoding: "utf-8")
categories.each do |c|
  Category.create(title: c["title"])
end

# Load items
filename = Rails.root.join("db/items.csv")
puts "Loading Items from the csv file: #{filename}"
csv_data = File.read(filename)
items = CSV.parse(csv_data, headers: true, encoding: "utf-8")
items.each do |i|
  category = Category.find_by(title: i["category"])

  next unless category&.valid?

  item = category.items.create(
    title:       i["title"],
    description: i["description"],
    price:       i["price"]
  )

  next unless item&.valid?

  query = URI.encode_www_form_component([item.title, category.title].join(","))
  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
  item.picture.attach(io:       downloaded_image,
                      filename: "item-#{[item.title, category.title].join('-')}.jpg")
  sleep(1) # <=== if youre downloading A LOT of images,
  # do yourself a favour and DONT get yourself blocked by spamming the API.
end

puts "Created #{Province.count} Provinces"
puts "Created #{Category.count} Categories"
puts "Created #{Item.count} Items"

AdminUser.create!(email: "admin@example.com", password: "password",
                  password_confirmation: "password")

User.create!(name: "Admin", email: "admin@example.com", phone: 2_042_222_222, province_id: Province.first.id, admin: true, password: "password",
             password_confirmation: "password")
