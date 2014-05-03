require 'spec_helper'

describe Priority do
  it "is not saved without a value" do
    p = Priority.create

    expect(p).not_to be_valid
    expect(Priority.count).to eq(0)
  end

  it "is saved if it has value" do
    p1 = FactoryGirl.create(:priority)

    expect(p1).to be_valid
    expect(Priority.count).to eq(1)
  end  

  describe "when has tasks" do
    it "has main tasks that belong to right user" do
      user = FactoryGirl.create(:user)
      mt1 = FactoryGirl.create(:main_task, name: "mt1")
      mt2 = FactoryGirl.create(:main_task, name: "mt2")
      user.tasks << mt1
      user.tasks << mt2
      p = FactoryGirl.create(:priority)
      p.tasks << mt1
      p.tasks << mt2

      tasks = p.maintasks(user)

      expect(tasks[0].name).to eq("mt1")
    end

    it "has subtasks that belong to right user" do
      user = FactoryGirl.create(:user)
      st1 = FactoryGirl.create(:subtask, name: "st1")
      st2 = FactoryGirl.create(:subtask, name: "st2")
      user.tasks << st1
      user.tasks << st2
      p = FactoryGirl.create(:priority)
      p.tasks << st1
      p.tasks << st2

      tasks = p.subtasks(user)

      expect(tasks[0].name).to eq("st1")
    end

    it "does not have subtasks in maintask list" do
      user = FactoryGirl.create(:user)

      st1 = FactoryGirl.create(:subtask, name: "st1")
      st2 = FactoryGirl.create(:subtask, name: "st2")

      mt1 = FactoryGirl.create(:main_task, name: "mt1")
      mt2 = FactoryGirl.create(:main_task, name: "mt2")
      user.tasks << st1
      user.tasks << st2
      user.tasks << mt1
      user.tasks << mt2

      p = FactoryGirl.create(:priority)

      p.tasks << st1
      p.tasks << st2
      p.tasks << mt1
      p.tasks << mt2

      tasks = p.maintasks(user)

      expect(tasks[0].name).to eq("mt1")
      expect(tasks[1].name).to eq("mt2")
      expect(tasks.length).to eq(2)
    end
  end
end


