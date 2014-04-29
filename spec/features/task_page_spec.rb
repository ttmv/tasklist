require 'spec_helper'

describe "when tasks exist" do
  User
  UsersController
  CategoriesController
  TasksCategoriesController
  TasksCategory
  it "lets user to navigate to the page of a task" do
    create_tasks
    visit tasks_path
    click_link "main task 1"

    expect(page).to have_content "Name: main task 1"
  end

  it "if it is a main task and has subtasks, lists them on the page" do
    create_tasks
    visit tasks_path
    click_link "main task 1"

    expect(page).to have_content "subtask 1"
    expect(page).to have_content "subtask 2"
  end

  it "when categories exist, they can be added to it" do
    create_tasks
    create_categories
    visit tasks_path
    click_link "main task 1"

    select 'second category', from: 'tasks_category[category_id]'
    expect{click_button 'add'}.to change{TasksCategory.count}.from(0).to(1)

    expect(page).to have_content 'second category remove'
  end  

  it "can be removed from category" do
    create_task_with_categories
    visit tasks_path
    click_link 'task with categories'

    expect{click_link 'remove'}.to change{TasksCategory.count}.from(1).to(0)
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

describe "An existing task" do
  it "can be updated to have a new name" do
    create_user
    sign_user_in
    maintask = MainTask.create name:"main task 1"
    visit tasks_path
    click_link "main task 1"
    click_link "Edit"

    fill_in('Name', with:'A new task name')
    click_button "Update Main task"

    expect(page).to have_content 'Name: A new task name'
  end

  it "can not be updated to not to have a name" do
    create_user
    sign_user_in
    maintask = MainTask.create name:"main task 1"
    visit tasks_path
    click_link "main task 1"
    click_link "Edit"

    fill_in('Name', with:'')
    click_button "Update Main task"
    
    expect(page).to have_content "Name can't be blank"
  end
  
  it "can be removed" do
    create_user
    sign_user_in
    maintask = MainTask.create name:"main task 1"

    visit tasks_path
    click_link "main task 1"
    
    expect{
      click_link "Destroy"
    }.to change{Task.count}.from(1).to(0)
    
  end
end

def create_tasks
  maintask = MainTask.create name:"main task 1"
  subtask = Subtask.create name: "subtask 1", main_task_id: maintask.id
  subtask2 = Subtask.create name: "subtask 2", main_task_id: maintask.id
end

def create_categories
  c1 = Category.create name: "first category"
  c2 = Category.create name: "second category"
end

def create_task_with_categories
  t = Task.create name:'task with categories'
  c1 = Category.create name: "first category"
#  c2 = Category.create name: "second category"
  t.categories << c1
#  t.categories << c2
end

def create_user
  User.create username:"testuser", password: "testpass", password_confirmation: "testpass"
end

def sign_user_in
  visit signin_path
  fill_in('username', with:'testuser')
  fill_in('password', with:'testpass')
  click_button "Log in"
end
