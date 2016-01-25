class AddcanTransportColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :can_transport,        :boolean
    add_column :users, :transport_detail,     :text
    add_column :users, :can_tourguide,        :boolean
    add_column :users, :tourguide_detail,     :text
    add_column :users, :can_accomendation,    :boolean
    add_column :users, :accomendation_detail, :text
    add_column :users, :can_pickup,    :boolean
    add_column :users, :pickup_detail, :text

  end
end
