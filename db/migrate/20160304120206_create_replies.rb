class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content
      t.integer :post_id
      t.integer :user_id
      t.integer :reply_to
      t.timestamps null: false
    end
  end
end
