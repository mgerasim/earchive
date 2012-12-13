class Person < ActiveRecord::Base

    set_table_name "users" 
    set_primary_key "id" 
    set_sequence_name "s_users"
    
    attr_accessible :nickname, :depart, :depart_id
    
    belongs_to :depart
    
    validates :nickname,    :presence => true,
			    :uniqueness => true
    
    validates :depart, :presence => true
	
    def self.authenticate(nickname, password)
	nil
    end
	

    def auth(nickname, password)
	Person.authenticate(nickname, password)
    end    
end
