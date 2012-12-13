require 'spec_helper'

describe "workers/new.html.erb" do
  before(:each) do
    assign(:worker, stub_model(Worker,
      :name => "MyString",
      :encrypted_password => "MyString",
      :depart => nil
    ).as_new_record)
  end

  it "renders new worker form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => workers_path, :method => "post" do
      assert_select "input#worker_name", :name => "worker[name]"
      assert_select "input#worker_encrypted_password", :name => "worker[encrypted_password]"
      assert_select "input#worker_depart", :name => "worker[depart]"
    end
  end
end
