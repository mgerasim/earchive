require 'digest'

class Worker < Person
 
    attr_accessor   :password
    attr_accessible :password, :password_confirmation, :encrypted_password
    
    validates :password, :confirmation => true

    def self.authenticate(nickname, password)
    
	return nil if password==nil || password==""
	user = find_by_nickname(nickname)
	if user
	    return user if user.has_password?(password)
	else
	    return nil
	end
    end
    
    
    def auth(nickname, password)
	Worker.authenticate(nickname, password)
    end
    
    before_save :encrypt_password
    
    # Return true if the user's password matches the submitted password.
      def has_password?(submitted_password)
          # Compare encrypted_password with the encrypted version of
          # submitted_password.
          encrypted_password == encrypt(submitted_password)
      end
                
    
      private
      
      def encrypt_password
                self.encrypted_password = encrypt(password)
      end
                    
      def encrypt(string)
            secure_hash("#{string}")
      end
                
      def secure_hash(string)
            Digest::SHA2.hexdigest(string)
      end
end
