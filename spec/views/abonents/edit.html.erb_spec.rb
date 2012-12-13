require 'spec_helper'

describe "abonents/edit.html.erb" do
  before(:each) do
    @abonent = assign(:abonent, stub_model(Abonent))
  end

  it "renders the edit abonent form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => abonents_path(@abonent), :method => "post" do
    end
  end
end
