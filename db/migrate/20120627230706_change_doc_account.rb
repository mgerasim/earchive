class ChangeDocAccount < ActiveRecord::Migration
  def change
    change_table :documents do |t|
	t.change :account, :integer
    end
  end
end
