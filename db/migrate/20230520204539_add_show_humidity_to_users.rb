class AddShowHumidityToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :show_humidity, :boolean, default: true
  end
end
