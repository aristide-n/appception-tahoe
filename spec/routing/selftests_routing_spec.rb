require "spec_helper"

describe SelftestsController do
  describe "routing" do

    it "routes to #index" do
      get("/selftests").should route_to("selftests#index")
    end

    it "routes to #new" do
      get("/selftests/new").should route_to("selftests#new")
    end

    it "routes to #show" do
      get("/selftests/1").should route_to("selftests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/selftests/1/edit").should route_to("selftests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/selftests").should route_to("selftests#create")
    end

    it "routes to #update" do
      put("/selftests/1").should route_to("selftests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/selftests/1").should route_to("selftests#destroy", :id => "1")
    end

  end
end
