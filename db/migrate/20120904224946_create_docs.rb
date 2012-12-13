class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :source
      t.integer :doc_type_id
      t.integer :doc_status_id
      t.string :account
      t.string :phone

      t.timestamps
    end
  end
end
