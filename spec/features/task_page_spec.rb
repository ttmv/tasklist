require 'spec_helper'

describe "when tasks exist" do
  User
  UsersController
  CategoriesController
  it "lets user to navigate to the page of a task" do
    create_tasks
    visit tasks_path
    click_link "main task 1"

    expect(page).to have_content "Name: main task 1"
  end

  it "and if it is a main task and has subtasks, lists them on the page" do
    create_tasks
    visit tasks_path
    click_link "main task 1"

    expect(page).to have_content "subtask 1"
    expect(page).to have_content "subtask 2"
  end  
end

describe "A new task" do
  it "is saved if it has a name" do
    Category.create name:"testikategoria"

    visit new_task_path

    fill_in('Name', with:'test')
    
    expect{
      click_button "Create Task"
    }.to change{Task.count}.from(0).to(1)

    task = Task.find_by name:"test"
    expect(task).to be_valid
    expect(task.type).to eq("MainTask")
  end
end

def create_tasks
  maintask = MainTask.create name:"main task 1"
  subtask = Subtask.create name: "subtask 1", main_task_id: maintask.id
  subtask2 = Subtask.create name: "subtask 2", main_task_id: maintask.id
end
