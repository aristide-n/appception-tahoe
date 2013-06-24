require "spec_helper"

describe TimelinesController do
  describe "routing" do

    it "routes to #index" do
      get("/timelines").should route_to("timelines#index")
    end

    it "routes to #new" do
      get("/timelines/new").should route_to("timelines#new")
    end

    it "routes to #show" do
      get("/timelines/1").should route_to("timelines#show", :id => "1")
    end

    it "routes to #edit" do
      get("/timelines/1/edit").should route_to("timelines#edit", :id => "1")
    end

    it "routes to #create" do
      post("/timelines").should route_to("timelines#create")
    end

    it "routes to #update" do
      put("/timelines/1").should route_to("timelines#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/timelines/1").should route_to("timelines#destroy", :id => "1")
    end

  end
end
