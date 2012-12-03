require "spec_helper"

describe FlirtsController do
  describe "routing" do

    it "routes to #index" do
      get("/flirts").should route_to("flirts#index")
    end

    it "routes to #new" do
      get("/flirts/new").should route_to("flirts#new")
    end

    it "routes to #show" do
      get("/flirts/1").should route_to("flirts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/flirts/1/edit").should route_to("flirts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/flirts").should route_to("flirts#create")
    end

    it "routes to #update" do
      put("/flirts/1").should route_to("flirts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/flirts/1").should route_to("flirts#destroy", :id => "1")
    end

  end
end
