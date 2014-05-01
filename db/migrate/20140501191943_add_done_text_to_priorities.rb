class AddDoneTextToPriorities < ActiveRecord::Migration
  def change
    add_column :priorities, :done_text, :string
  end
end
