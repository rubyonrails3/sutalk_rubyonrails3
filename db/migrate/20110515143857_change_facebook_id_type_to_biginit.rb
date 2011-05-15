class ChangeFacebookIdTypeToBiginit < ActiveRecord::Migration
  def self.up
    change_column :users, :facebook_id, :string 
    add_index(:users, :facebook_id, :unique => true)
  end

  def self.down 
    remove_index(:users, :facebook_id)
    change_column :users, :facebook_id, :integer
  end
end
