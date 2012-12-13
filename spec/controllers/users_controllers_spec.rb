require 'spec_helper'

describe UsersController do
    render_views
    
    describe "get local users" do
	    before(:each) do
		@user = Factory(:user)
		test_sign_in(@user)
	    end
	    
	    it "should get ldap users xml format" do
	    	post :index
#	        response.should redirect_to(root_path)
#	        controller.current_user.should == @user
		controller.should be_signed_in
            end
	    
    end
    
    
end