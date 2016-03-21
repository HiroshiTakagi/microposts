class AddLocationProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location, :text
    add_column :users, :profile, :text
  end
end
