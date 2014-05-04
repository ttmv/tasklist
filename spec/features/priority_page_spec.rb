require 'spec_helper'

describe "An existing priority" do
  before :each do
    FactoryGirl.create(:user)
    FactoryGirl.create(:priority, description: "priority 1")
    sign_user_in
    visit priorities_path
  end

  it "is shown on index page" do
    expect(page).to have_content "4 priority 1"
  end

  it "can be navigated to" do
    click_link 'priority 1'

    expect(page).to have_content "Priority level 4 -- priority 1"    
    expect(page).to have_content "Tasks with this priority:"
  end

  it "if several, all are listed on the priority index page" do
    FactoryGirl.create(:priority, value: 2, description: "priority 2")    

    visit priorities_path

    expect(page).to have_content "4 priority 1"
    expect(page).to have_content "2 priority 2"
  end

  it "can be destroyed" do 
    click_link "Destroy"

    expect(Priority.count).to eq(0)
  end
  
  describe "can be updated" do
    it "to have a new value" do
      click_link "priority 1"
      click_link "Edit"
      fill_in('Value', with:'10')      
      click_button 'Update Priority'

      expect(page).to have_content "Priority level 10"
    end

    it "to have a new description text" do
      click_link "priority 1"
      click_link "Edit"
      fill_in('Description', with:'A new description')
      click_button 'Update Priority'

      expect(page).to have_content "A new description"    
    end

    it "but not to have an empty value" do
      click_link "priority 1"
      click_link "Edit"
      fill_in('Value', with:'')      
      click_button 'Update Priority'

      expect(page).to have_content "Value can't be blank"
    end
  end
end

describe "A new priority" do
  before :each do
    FactoryGirl.create(:user)
    sign_user_in
  end

  it "can be added from page" do
    visit priorities_path
    click_link "New Priority"
    fill_in('Value', with:'1')
    fill_in('Description', with:'A new priority')

    expect{click_button 'Create Priority'}.to change{Priority.count}.from(0).to(1)
   
    expect(page).to have_content "Priority level 1 -- A new priority" 
  end

  it "can not be added without value" do
    visit priorities_path
    click_link "New Priority"
    fill_in('Value', with:'')
    fill_in('Description', with:'A new priority')

    expect{click_button 'Create Priority'}.not_to change{Priority.count}.from(0).to(1)
   
    expect(page).to have_content "Value can't be blank"
  end

end
