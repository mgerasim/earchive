class InfoController < ApplicationController

    before_filter :authorize

    def doctypes
	@doctypes = Doctype.all
	respond_to do |format|
          format.xml { render xml: @doctypes }
	end
    end
    
    def users
	@users = User.find(:all, :conditions => "is_valid = 'Y'")
	respond_to do |format|
	    format.xml { render :layout=>false }
	end
    end
    
    def workers
	@users = Worker.find(:all, :conditions => "is_valid = 'Y'")
	respond_to do |format|
	    format.xml { render :layout=>false }
	end
    end

    
    def auth
	log = Logger.new(STDOUT)
	@login 	= params[:login]
	@pass 	= params[:pass]
	@auth   = 0;
	person  = Person.find_by_nickname(@login)
	if person
            @auth = 1 if person.auth(@login, @pass)
        end
	respond_to do |format|
	    format.xml {render :layout=>false }
	end
    end
end
