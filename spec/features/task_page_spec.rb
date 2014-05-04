require 'spec_helper'

describe "Existing tasks" do
  User
  UsersController
  Category
  CategoriesController
  TasksCategoriesController
  TasksCategory
  SubtasksController
  Subtask


  before :each do
    user = FactoryGirl.create(:user)
    sign_user_in

    main_task = FactoryGirl.create(:main_task)
    subtask1 = FactoryGirl.create(:subtask)
    subtask2 = FactoryGirl.create(:subtask, name: "Subtask 2")

    main_task.subtasks << subtask1
    main_task.subtasks << subtask2

    user.tasks << main_task
    user.tasks << subtask1
    user.tasks << subtask2

    create_task_with_categories(user)

    visit tasks_path
  end

  it "lets user to navigate to the page of a task" do
    click_link "main task 1"
    
    expect(page).to have_content "main task 1"
  end

  it "if it is a main task and has subtasks, lists them on its page" do
    click_link "main task 1"

    expect(page).to have_content "Subtask 1"
    expect(page).to have_content "Subtask 2"
  end

  it "can be updated to have a new name" do
    page.first(:link, "Edit").click
    fill_in('Name', with:'A new task name')
    
    expect{ click_button "Update Main task" }.to change{Task.count}.by(0)
    expect(page).to have_content 'A new task name'
  end

  it "can not be updated to not to have a name" do
    page.first(:link, "Edit").click
    fill_in('Name', with:'')
    click_button "Update Main task"
    
    expect(page).to have_content "Name can't be blank"
  end

  it "can be removed" do
    expect{
      page.first(:link, "Destroy").click
    }.to change{Task.count}.by(-3)    
  end

  it "can be marked done" do
    page.first(:button, "Done!").click

    expect(Task.find_by(name: "main task 1").done).to eq(true)
  end


  it "when categories exist, they can be added to it" do
    create_categories
    visit tasks_path
    click_link "main task 1"

    select 'second category', from: 'tasks_category[category_id]'
    expect{click_button 'add'}.to change{TasksCategory.count}.from(1).to(2)

    expect(page).to have_content 'second category remove'
  end  
end

describe "A new task" do
  it "is saved if it has a name" do
    create_user
    sign_user_in

    visit new_task_path
    fill_in('Name', with:'test')
    
    expect{
      click_button "Create Main task"
    }.to change{Task.count}.from(0).to(1)

    task = Task.find_by name:"test"
    expect(task).to be_valid
    expect(task.type).to eq("MainTask")
  end

  it "can not be created without a name" do 
    create_user
    sign_user_in
    visit new_task_path

    fill_in('Name', with:'')
    click_button "Create Main task"

    expect(page).to have_content "Name can't be blank"
    expect(Task.count).to eq(0)    
  end
end


def create_categories
  c1 = FactoryGirl.create(:category)
  c2 = FactoryGirl.create(:category2)
end

def create_task_with_categories(user)
  t = FactoryGirl.create(:main_task, name: 'task with categories')
  c3 = FactoryGirl.create(:category, name: '3rd category')
  t.categories << c3
  user.tasks << t
end

def create_user
  FactoryGirl.create(:user)
end

def sign_user_in
  visit signin_path
  fill_in('username', with:'testuser')
  fill_in('password', with:'testpass')
  click_button "Log in"
end
