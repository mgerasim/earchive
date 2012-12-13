#encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  include LoginHelper
  
    private
  	def authorize
  		unless Person.find_by_id(session[:user_id])
  			flash[:notice] = "Пожалуйста, пройдите авторизацию"
  			redirect_to login_path
  		end
  	end
end
