class CreateNationJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :countries do |t|
      t.index [:user_id, :country_id]
      t.index [:country_id, :user_id]
    end

  end
end
