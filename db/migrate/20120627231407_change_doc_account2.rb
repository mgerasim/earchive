class ChangeDocAccount2 < ActiveRecord::Migration
  def change
    change_table :documents do |t|
	t.change :account, :string
    end
  end
end
