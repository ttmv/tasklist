class AddMainTaskIdToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :main_task_id, :integer
  end
end
