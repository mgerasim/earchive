require 'spec_helper'

describe "abonents/new.html.erb" do
  before(:each) do
    assign(:abonent, stub_model(Abonent).as_new_record)
  end

  it "renders new abonent form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => abonents_path, :method => "post" do
    end
  end
end
