class CreatePriorities < ActiveRecord::Migration
  def change
    create_table :priorities do |t|
      t.integer :value
      t.string :description

      t.timestamps
    end
  end
end
