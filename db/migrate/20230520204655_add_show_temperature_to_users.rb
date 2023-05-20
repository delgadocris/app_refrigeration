class AddShowTemperatureToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :show_temperature, :boolean, default: true
  end
end
