class CreateLanguageJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :languages do |t|
      t.index [:user_id, :language_id]
      t.index [:language_id, :user_id]
    end
  end
end
