class AddUserIdToBranches < ActiveRecord::Migration[7.0]
  def change
    add_reference :branches, :user, null: false, foreign_key: true
  end
end
