class AddHumidityToBranches < ActiveRecord::Migration[7.0]
  def change
    add_column :branches, :humidity, :string, default: 0
  end
end
