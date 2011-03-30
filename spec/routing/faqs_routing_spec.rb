require "spec_helper"

describe FaqsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/faqs" }.should route_to(:controller => "faqs", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/faqs/new" }.should route_to(:controller => "faqs", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/faqs/1" }.should route_to(:controller => "faqs", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/faqs/1/edit" }.should route_to(:controller => "faqs", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/faqs" }.should route_to(:controller => "faqs", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/faqs/1" }.should route_to(:controller => "faqs", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/faqs/1" }.should route_to(:controller => "faqs", :action => "destroy", :id => "1")
    end

  end
end
