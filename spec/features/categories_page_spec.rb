require 'spec_helper'

describe 'A new category' do
  it 'can be saved with a valid name' do
    visit new_category_path
    fill_in('Name', with:'test category')

    expect{
      click_button "Create Category"
    }.to change{Category.count}.from(0).to(1)

    expect(page).to have_content 'Name: test category'
  end

  it 'can not be saved without valid name' do
    visit new_category_path
    fill_in('Name', with:'')

    click_button "Create Category"
    
    expect(Category.count).to eq(0)
    expect(page).to have_content "Name can't be blank"
  end
end

describe 'An existing category' do
  it 'can be seen in categories page' do
    create_category
    visit categories_path

    expect(page).to have_content 'testcateg'
  end

  it 'can be navigated to' do
    create_category
    visit categories_path

    click_link 'testcateg'

    expect(page).to have_content 'Name: testcateg'
  end

  it 'can be updated to have a new name' do
    create_category
    
    visit categories_path
    click_link 'testcateg'
    click_link 'Edit'

    fill_in('Name', with:'asdf')
    click_button('Update Category')

    expect(page).to have_content 'Name: asdf'
    expect(Category.count).to eq(1)
  end

  it 'can not be updated to not to have an empty name' do
    create_category

    visit categories_path
    click_link 'testcateg'
    click_link 'Edit'

    fill_in('Name', with:'')
    click_button('Update Category')

    expect(page).to have_content "Name can't be blank"
    expect(Category.count).to eq(1)    
  end

  it 'can be destroyed' do
    create_category
    visit categories_path
    click_link 'testcateg'

    expect{click_link 'Destroy'}.to change{Category.count}.from(1).to(0)    
  end
end

def create_category
  Category.create name: "testcateg" 
end
