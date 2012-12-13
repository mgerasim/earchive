class ChangeDocPhone < ActiveRecord::Migration
  def change
    change_table :documents do |t|
	t.change :phone, :string
    end
  end
end
