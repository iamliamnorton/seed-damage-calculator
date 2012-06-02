require 'spec_helper'

describe "Pages" do
  
  before(:each) do
    visit root_path
  end
  
  describe "- when a user visits the definitions page -" do
    it "page is rendered" do
      click_link "Definitions"
      page.driver.response.status.should == 200
    end
  end
  
  describe "- when a user visits the disclaimer page -" do
    it "page is rendered" do
      click_link "Disclaimer"
      page.driver.response.status.should == 200
    end
  end
  
  describe "- when a user visits the theory page -" do
    it "page is rendered" do
      click_link "Theory"
      page.driver.response.status.should == 200
    end
  end
end
