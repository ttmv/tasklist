require 'spec_helper'

describe "when tasks exist" do
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

def create_tasks
  maintask = MainTask.create name:"main task 1"
  subtask = Subtask.create name: "subtask 1", main_task_id: maintask.id
  subtask2 = Subtask.create name: "subtask 2", main_task_id: maintask.id
end
