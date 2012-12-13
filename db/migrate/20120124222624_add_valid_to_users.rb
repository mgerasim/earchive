class AddValidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :valid, :boolean, :default => true
  end
end
