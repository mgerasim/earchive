class Docattr < ActiveRecord::Base
    set_table_name "doc_attributes" 
    
    belongs_to	:document,
		:class_name 	=> "Document",
		:foreign_key	=> "doc_id"
		
    belongs_to 	:attribute,
		:class_name	=> "Attribute",
		:foreign_key	=> "attribute_id"
end
