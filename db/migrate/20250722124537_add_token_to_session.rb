class AddTokenToSession < ActiveRecord::Migration[8.0]
  def change
    add_column :sessions, :token_digest, :string
  end
end
