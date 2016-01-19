class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :gender
      t.integer :age
      t.string :nationality
      t.integer :countries_want_to_go, array: true, default: []
      t.boolean :willing_to_host, default: false
      t.string :password_digest
      t.boolean :confirmed
      t.string :confirm_token
      t.string :access_token
      t.references :city, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
