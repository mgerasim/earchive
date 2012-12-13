require "spec_helper"

describe AbonentsController do
  describe "routing" do

    it "routes to #index" do
      get("/abonents").should route_to("abonents#index")
    end

  end
end
