class CreateBranches < ActiveRecord::Migration[7.0]
  def change
    create_table :branches do |t|
      t.string :fridge
      t.string :temperature

      t.timestamps
    end
  end
end
