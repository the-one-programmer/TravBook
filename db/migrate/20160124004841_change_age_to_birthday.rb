class ChangeAgeToBirthday < ActiveRecord::Migration
  def up
    remove_column :users, :age
    add_column :users, :birthday, :date
  end

  def down
    add_column :users, :age, :integer
    remove_column :users, :birthday
  end
end
