class AddDefaultsToUser < ActiveRecord::Migration
  def up
    change_column_default :users, :confirmed, false
    change_column_default :users, :gender, 0
  end

  def down
    change_column_default :users, :confirmed, nil
    change_column_default :users, :gender, nil
  end
end
