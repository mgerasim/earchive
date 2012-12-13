#encoding: utf-8

class LoginController < ApplicationController


  def logup
    flash.now[:notice] = "Пользователь  зарегистрирован"
  	@user = User.new(params[:user])
  	if request.post? and @user.save
  		flash.now[:notice] = "Пользователь #{@user.name} зарегистрирован"
#  		@user = User.new
  	end
  end

  def login
  
    @title = 'Вход'
  
    @Users = User.find(:all, :order => :lastname)
    
    flash[:error] = "В системе не заведено ни одного пользователя!" if @Users.count == 0
    
    session[:user_id] = nil
    if request.post?
	begin
    	    user = User.authenticate(params["ldap_account"], params["password"])
	rescue
	    flash[:error] =  "Зарегестрируйте в системе первого пользователя!"
	else 
    	    if user
    		session[:user_id] = user.id
    		self.current_user = user
    		redirect_to(root_path)
    	    else
    		flash[:error] = "Неверная комбинация имя-пароль"
    	    end
    	end
    end
  end
  
  def auth
    @auth_code="FAILED"
    session[:user_id] = nil
    user = Person.find_by_nickname(params["ldap_account"])
    log = Logger.new(STDOUT)
    log.debug(user)
    if user == nil
	log.debug("user is nil")
	render :layout => false
    end
    
	begin
	    if user.auth(params["ldap_account"], params["password"])
		log.debug("user is auth")
		session[:user_id] = user.id 
		self.current_user = user
		@auth_code="OK"
		render :layout => false
	    else
	    	log.debug("user is not auth")
	    	render :layout => false
	    end
	rescue
	    log.debug("user is rescue")
#    	    render :layout => false
	else
	    log.debug("user is else")
#	    render :layout => false
	end
    
  end
  
  def logout
    session[:user_id] = nil
    self.current_user = nil
    flash[:notice] = "Вы вышли из административной области "
    redirect_to login_path
  end

end
