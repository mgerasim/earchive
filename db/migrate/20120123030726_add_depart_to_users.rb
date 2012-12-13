class AddDepartToUsers < ActiveRecord::Migration
  def change
    add_column :users, :depart_id, :integer
  end
end
