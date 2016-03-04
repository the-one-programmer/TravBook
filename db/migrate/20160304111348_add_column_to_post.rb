class AddColumnToPost < ActiveRecord::Migration
  def change
    add_column :posts, :original_post_id, :integer
  end
end
