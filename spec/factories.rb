FactoryGirl.define do
  factory :user do
    username "testuser"
    password "testpass"
    password_confirmation "testpass" 
  end

  factory :category do
    name "first category"
  end

  factory :category2, class: Category do
    name "second category"
  end

  factory :main_task do
    name "main task 1"
  end

  factory :subtask do
    name "Subtask 1"
  end

  factory :priority do
    value 4
  end
end
