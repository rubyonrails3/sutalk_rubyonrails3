class ChangeFacebookIdTypeToBiginit < ActiveRecord::Migration
  def self.up
    change_column :users, :facebook_id, :int64, :limit => 16
  end

  def self.down
    change_column :users, :facebook_id, :integer
  end
end
