#encoding: utf-8
require 'spec_helper'

describe Worker do
    before(:each) do
	@attr = {
	    :password => "TestPass",
	    :nickname => "TestName"
	}
	
	@worker = Worker.create!(@attr)
    end
    
    it "should be true if the passwords match" do
	@worker.has_password?(@attr[:password]).should be_true
    end
    
    it "should be false if the passwords don't match" do
        @worker.has_password?("invalid").should be_false
    end
        
    it "should return nil on nickname/password mismatch" do
        wrong_password_worker = Worker.authenticate(@attr[:nickname], "wrongpass")
        wrong_password_worker.should be_nil
    end
    
    it "should return the user on nickname/password match" do
        matching_user = Worker.authenticate(@attr[:nickname], @attr[:password])
        matching_user.should == @worker
    end


end