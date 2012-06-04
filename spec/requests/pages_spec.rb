require 'spec_helper'

describe "Pages" do
  
  describe "- when a user visits the definitions page -" do
    it "page is rendered" do
      visit definitions_path
      page.driver.response.status.should == 200
    end
  end
  
  describe "- when a user visits the disclaimer page -" do
    it "page is rendered" do
      visit disclaimer_path
      page.driver.response.status.should == 200
    end
  end
  
  describe "- when a user visits the theory page -" do
    it "page is rendered" do
      visit theory_path
      page.driver.response.status.should == 200
    end
  end
end
