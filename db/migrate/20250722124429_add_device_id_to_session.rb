class AddDeviceIdToSession < ActiveRecord::Migration[8.0]
  def change
    add_column :sessions, :device_id, :string
  end
end
