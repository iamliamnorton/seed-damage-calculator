require 'spec_helper'

describe "Pages", type: :feature do

  describe "- when a user visits the definitions page -" do
    it "page is rendered" do
      visit definitions_path
      expect(page.driver.response.status).to eq(200)
    end
  end

  describe "- when a user visits the disclaimer page -" do
    it "page is rendered" do
      visit disclaimer_path
      expect(page.driver.response.status).to eq(200)
    end
  end

  describe "- when a user visits the theory page -" do
    it "page is rendered" do
      visit theory_path
      expect(page.driver.response.status).to eq(200)
    end
  end
end
