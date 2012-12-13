#encoding: utf-8
require 'spec_helper'

describe LoginController do
    render_views

    
    describe "POST LocalAuth" do
	describe "invalid login" do
	    before (:each) do
		@attr = { :ldap_account => "email@example.com", :password => "invalid" }
	    end	
	    
	    it "should re-render the new page" do
	        post :localauth, @attr
		response.should render_template('localauth')
	    end
	    
	    it "should have the right title" do
	        post :localauth, @attr
		response.should have_selector("title", :content => "Электронный архив | Вход")
	    end
	    
	    it "should have a flash.now message" do
	        post :localauth, @attr
		flash.now[:error].should =~ /Неверная/i
	    end
	end
    end

    

    describe "POST LdapAuth" do
	describe "invalid login" do
	    before (:each) do
		@attr = { :ldap_account => "email@example.com", :password => "invalid" }
	    end	
	    
	    it "should re-render the new page" do
	        post :ldapauth, @attr
		response.should render_template('ldapauth')
	    end
	    
	    it "should have the right title" do
	        post :ldapauth, @attr
		response.should have_selector("title", :content => "Электронный архив | Вход")
	    end
	    
	    it "should have a flash.now message" do
	        post :ldapauth, @attr
		flash.now[:error].should =~ /Неверная/i
	    end
	end
    end


    describe "POST login" do
	describe "invalid login" do
	    before (:each) do
		@attr = { :ldap_account => "email@example.com", :password => "invalid" }
	    end	
	    
	    it "should re-render the new page" do
	        post :login, :login => @attr
		response.should render_template('login')
	    end
	    
	    it "should have the right title" do
	        post :login, :login => @attr
		response.should have_selector("title", :content => "Электронный архив | Вход")
	    end
	    
	    it "should have a flash.now message" do
	        post :login, :login => @attr
		flash.now[:error].should =~ /Неверная/i
	    end
	end
	
	describe "with valid account and password" do
	    before(:each) do
		@user = Factory(:user)
		@attr = { :ldap_account => "h02-GerasimovMN", :password => "Cegth1Yjdsq2Gfhjkm3" }
	    end
	    
	    it "should sign the user in" do
	        post :login,  @attr
	        response.should redirect_to(root_path)
	        controller.current_user.should == @user
		controller.should be_signed_in
            end
	    
	end
	
    end
    
    
    
    
end