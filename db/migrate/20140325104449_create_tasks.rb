class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :date
      t.boolean :done
      t.string :type
      t.text :info

      t.timestamps
    end
  end
end
