require "spec_helper"

describe EnvironmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/environments").should route_to("environments#index")
    end

    it "routes to #new" do
      get("/environments/new").should route_to("environments#new")
    end

    it "routes to #show" do
      get("/environments/1").should route_to("environments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/environments/1/edit").should route_to("environments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/environments").should route_to("environments#create")
    end

    it "routes to #update" do
      put("/environments/1").should route_to("environments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/environments/1").should route_to("environments#destroy", :id => "1")
    end

  end
end
