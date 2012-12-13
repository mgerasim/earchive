class Doctype < ActiveRecord::Base
    set_table_name "doc_type" 
    set_primary_key "doc_type_id" 
    set_sequence_name "s_doc_type"
    
    has_many :documents
    
    validates :name, :presence => true
    			
    
    validates :short_name, :presence => true
    			


end
