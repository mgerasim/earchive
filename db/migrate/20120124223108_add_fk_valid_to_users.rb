class AddFkValidToUsers < ActiveRecord::Migration
  def up
    execute <<-SQL
	ALTER TABLE documents
	ADD CONSTRAINT fk_users
        FOREIGN KEY (add_user)
        REFERENCES users(id)
    SQL
  end
  
  def down
    execute <<-SQL
	ALTER TABLE documentss
	        DROP FOREIGN KEY fk_users
    SQL
  end
end
