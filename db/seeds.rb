require "csv"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Province.delete_all
Category.delete_all
User.delete_all

filename = Rails.root.join("db/provinces.csv")

puts "Loading Movies from the csv file: #{filename}"

csv_data = File.read(filename)
provinces = CSV.parse(csv_data, headers: true, encoding: "utf-8")

provinces.each do |m|
  Province.create(
    title: m["title"],
    pst:   m["pst"],
    gst:   m["gst"]
  )
end

puts "Created #{Province.count} Provinces"
