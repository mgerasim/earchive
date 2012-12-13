module LoginHelper

    def signed_in?
        !current_user.nil?
    end
          
    def sign_in(user)
    #    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
        self.current_user = user
        session[:user_id] = user
    end
    
    def current_user=(user)
        @current_user = user
          end
          
            def current_user
                @current_user     # Бесполезно! Не используйте эту строку.
                  end
    
end
