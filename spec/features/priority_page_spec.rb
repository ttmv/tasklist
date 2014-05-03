require 'spec_helper'

describe "when priority exists" do
  it "is shown on index page" do
    FactoryGirl.create(:priority, description: "priority 1")    
    visit priorities_path

    expect(page).to have_content "4 priority 1"
  end

  it "can be navigated to" do
    FactoryGirl.create(:priority, description: "priority 1")
    visit priorities_path
    click_link 'priority 1'

    expect(page).to have_content "Priority level 4 -- priority 1"    
    expect(page).to have_content "Tasks with this priority:"
  end

  it "if several, all are listed on the priority index page" do
    FactoryGirl.create(:priority, description: "priority 1")
    FactoryGirl.create(:priority, value: 2, description: "priority 2")    
    
    visit priorities_path

    expect(page).to have_content "4 priority 1"
    expect(page).to have_content "2 priority 2"
  end
end
