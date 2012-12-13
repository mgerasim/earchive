#encoding: utf-8

class User < Person

    ROLES = %w[Супервизор Администратор Пользователь]
    
    attr_accessor :password

    attr_accessible :lastname, :firstname , :secondname, :depart_id, :depart, :is_valid, :role
    
    validates :lastname, :presence => true
    validates :firstname, :presence => true
    validates :secondname, :presence => true
    validates :role, :presence => true
    validates :password, :confirmation => true

    def self.find_valid()
	where("is_valid = 'Y'")
    end
    
    def self.authenticate(nickname, password)
    
	return nil if password==nil || password==""
	
    	user = find_by_nickname(nickname)
    	Rails.logger.info "user"
    	Rails.logger.info user
    	if user
    	    nickname.downcase
    	    nickname = "CORP\\#{nickname}"
    	    ldap = Net::LDAP.new(
    	        host: '10.198.1.227',
    	        port: 389,
    	        auth: { method: :simple, username: nickname, password: password }
    	    ) 
    	    return user if ldap.bind
    	    
    	end
    	
    	return nil
    end


    def auth(nickname, password)
	User.authenticate(nickname, password)
    end    
    
    def logonname
	"#{lastname} #{firstname[0]}. #{secondname[0]}."
    end
    

end
