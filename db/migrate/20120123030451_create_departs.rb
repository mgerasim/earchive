class CreateDeparts < ActiveRecord::Migration
  def change
    create_table :departs do |t|
      t.string :name

      t.timestamps
    end
  end
end
