# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Interest.delete_all
Country.delete_all
City.delete_all
Interest.create(:name => "swimming")
Country.create(:name => "China")
Country.create(:name => "Singapore")
City.create(:name => "Shanghai" , :country_id => 1)
City.create(:name => "Nanjing", :country_id => 1)
City.create(:name => "Singapore", :country_id => 2)

