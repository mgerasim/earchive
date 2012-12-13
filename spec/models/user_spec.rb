#encoding: utf-8
require 'spec_helper'

describe User do

    before (:each) do
	@attr = {
	    :nickname => "h02-GerasimovMN",
	    :lastname => "LastTest",
	    :firstname => "FirstTest",
	    :secondname => "SecondTest",
	    :depart_id => 1,
	    :role => "Пользователь"
	}
	@user = User.create!(@attr)
    end

    it "create success" do
	@user_created = Person.find_by_id(@user)
	@user_created.should == @user
    end

    it "should require a nickname" do
	    no_name_user = User.new(@attr.merge(:nickname => ""))
	    no_name_user.should_not be_valid
    end
    it "should unigueness a nickname" do
	    user_with_duplicate = User.new(@attr)
	    user_with_duplicate.should_not be_valid
    end
    
    it "should require a lastname" do
	    no_name_user = User.new(@attr.merge(:lastname => ""))
	    no_name_user.should_not be_valid
    end
    
    it "should require a firstname" do
	    no_name_user = User.new(@attr.merge(:firstname => ""))
	    no_name_user.should_not be_valid
    end
    
    it "should require a depart" do
	    no_name_user = User.new(@attr.merge(:depart_id => nil))
	    no_name_user.should_not be_valid
    end
    
    it "should require a role" do
	    no_name_user = User.new(@attr.merge(:role => ""))
	    no_name_user.should_not be_valid
    end

    describe "AD authenticate method" do
	it "should return nil on nickname/password mismatch" do
	    wrong_password_user = User.authenticate(@attr[:nickname], "wrongpass")
	    wrong_password_user.should be_nil
	end
	
	it "should return the user on nickname/password match" do
            matching_user = User.authenticate(@attr[:nickname], "Cegth1Yjdsq2Gfhjkm3")
            matching_user.should == @user
        end
	
    end
    
    describe "find valid users" do
	it "should return valid users" do
	    valid_user = User.find_valid().first
	    valid_user.should be_true
	end
    end

end