class ChangeDocAddUser < ActiveRecord::Migration
  def up
	rename_column :documents, :add_user, :user_id 
  end

  def down
	rename_column :documents, :user_id, :add_user
  end
end
