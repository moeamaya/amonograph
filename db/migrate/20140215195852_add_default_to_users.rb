class AddDefaultToUsers < ActiveRecord::Migration
  def change
    change_column :users, :invitation_limit, :integer, :default => 3
  end
end
