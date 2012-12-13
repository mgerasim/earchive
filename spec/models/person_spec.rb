require 'spec_helper.rb'

describe Person do
    before (:each) do
	depart = Depart.create!(:name => "TEST")
	@attr = {
	    :nickname => "TestPerson",
	    :depart => depart
	}
	@person = Person.create!(@attr)
    end

    it "create success" do
	@person_created = Person.find_by_id(@person)
	@person_created.should == @person
    end

    it "should require a nickname" do
	    no_name_user = Person.new(@attr.merge(:nickname => ""))
	    no_name_user.should_not be_valid
    end
    it "should unigueness a nickname" do
	    user_with_duplicate = Person.new(@attr)
	    user_with_duplicate.should_not be_valid
    end
    
    it "should invalid depart" do
	user_not_depart = Person.new(@attr.merge(:depart => nil))
	user_not_depart.should_not be_valid
    end
    
end