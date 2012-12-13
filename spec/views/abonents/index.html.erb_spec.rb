require 'spec_helper'

describe "abonents/index.html.erb" do
  before(:each) do
    assign(:abonents, [
      stub_model(Abonent),
      stub_model(Abonent)
    ])
  end

  it "renders a list of abonents" do
    render
  end
end
