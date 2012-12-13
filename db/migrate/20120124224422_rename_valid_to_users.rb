class RenameValidToUsers < ActiveRecord::Migration
  def up
    rename_column :users, :valid, :is_valid
  end

  def down
    rename_column :users, :is_valid, :valid
  end
end
