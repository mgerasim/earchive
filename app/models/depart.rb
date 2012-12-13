class Depart < ActiveRecord::Base

    set_table_name "departments" 
    set_primary_key :id
    set_sequence_name "s_departments"

    has_many :users,
	     :conditions => "is_valid = 'Y'"
end
