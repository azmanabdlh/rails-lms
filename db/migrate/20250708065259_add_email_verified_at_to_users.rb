class AddEmailVerifiedAtToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :email_verified_at, :datetime, null: true
  end
end
