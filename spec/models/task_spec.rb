require 'spec_helper'

describe Task do
  it "is not saved without a name" do
    task = Task.create
    
    expect(task).not_to be_valid
    expect(Task.count).to eq(0)
  end

  it "is saved with a valid name" do
    task = Task.create name:"task 1"

    expect(task).to be_valid
    expect(Task.count).to eq(1)
  end
end
