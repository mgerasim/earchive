class AddIsNotAdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_not_ad, :boolean, :default => 0
  end
end
