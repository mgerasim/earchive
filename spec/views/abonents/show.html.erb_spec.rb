require 'spec_helper'

describe "abonents/show.html.erb" do
  before(:each) do
    @abonent = assign(:abonent, stub_model(Abonent))
  end

  it "renders attributes in <p>" do
    render
  end
end
