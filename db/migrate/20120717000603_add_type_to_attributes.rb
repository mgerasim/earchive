class AddTypeToAttributes < ActiveRecord::Migration
  def change
    add_column :attribute_type, :attr_type, :string, :default => 'string'
  end
end
