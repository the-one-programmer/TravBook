# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Interest.delete_all
Country.delete_all
City.delete_all
Language.delete_all

Interest.create(:name => "swimming", :id => 1)
Interest.create(:name => "photography", :id => 2)
Interest.create(:name => "hiking", :id => 3)
Interest.create(:name => "etc", :id => 4)

Country.create(:name => "China", :id => 1)
Country.create(:name => "Singapore", :id => 2)
City.create(:name => "Shanghai" , :country_id => 1, :id => 1)
City.create(:name => "Nanjing", :country_id => 1, :id => 2)
City.create(:name => "Singapore", :country_id => 2, :id => 3)

Language.create(:name => "Chinese", :id => 1)
Language.create(:name => "English", :id => 2)
Language.create(:name => "Japanese", :id => 3)
Language.create(:name => "Korean", :id => 4)
Language.create(:name => "Vietamese", :id => 5)

User.create(:name => "matanghao", :email=>"ma.tanghao@dhs.sg", :password=>"123",:city_id=>2,:id=>1)
User.create(:name => "Ying Tao", :email=>"tao.ying@vjc.sg", :password=>"123",:city_id=>2,:id=>2)
User.create(:name => "Koh Jing Yu", :email=>"koh.jingyu@dhs.sg", :password=>"123",:city_id=>3,:id=>3)
matanghao = User.find(1)
[1,2].each do |interest_id|
  if (Interest.exists?(:id => interest_id))
    matanghao.interests << Interest.find(interest_id)
  end
end
kohjingyu = User.find(3)
[2,3].each do |interest_id|
  if (Interest.exists?(:id => interest_id))
    kohjingyu.interests << Interest.find(interest_id)
  end
end