class CreateTasksCategories < ActiveRecord::Migration
  def change
    create_table :tasks_categories do |t|
      t.integer :task_id
      t.integer :category_id

      t.timestamps
    end
  end
end
