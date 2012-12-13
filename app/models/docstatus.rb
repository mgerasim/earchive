class Docstatus < ActiveRecord::Base
    set_table_name "doc_status" 
    set_primary_key "doc_status_id" 
    set_sequence_name "s_doc_status"
    
    has_many :documents
end
