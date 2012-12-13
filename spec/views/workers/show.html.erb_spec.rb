require 'spec_helper'

describe "workers/show.html.erb" do
  before(:each) do
    @worker = assign(:worker, stub_model(Worker,
      :name => "Name",
      :encrypted_password => "Encrypted Password",
      :depart => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Encrypted Password/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
