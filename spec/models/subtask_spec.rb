require 'spec_helper'

describe Subtask do
  it "is saved with a main task id" do
    maintask = MainTask.create name:"main task 1"
    task = Subtask.create name: "subtask 1", main_task_id: maintask.id

    expect(task).to be_valid
    expect(Task.count).to eq(2)
    expect(Subtask.count).to eq(1)
    expect(task.main_task.name).to eq("main task 1")
  end
end
