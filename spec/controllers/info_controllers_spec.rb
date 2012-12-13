#encoding: utf-8
require 'spec_helper'

describe InfoController do
    render_views
    
    describe "get local users" do
	    before(:each) do
#		@user = Factory(:user)
#		@attr = { :ldap_account => "h02-GerasimovMN", :password => "Cegth1Yjdsq2Gfhjkm3" }
		@user = Factory.build(:user)
		test_sign_in(@user)
	    end
	    
	    it "should get users xml format" do
	    	post :users, :format => 'xml'
	    	response.status.should eq(200)
            end
	    
	    it "should get workers xml format" do
	    	post :workers, :format => 'xml'
	    	response.status.should eq(200)
            end

    end
    
    
end