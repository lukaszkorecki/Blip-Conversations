class AddBlipColumns < ActiveRecord::Migration
  def self.up
    add_column :blips, :blip_id, :int
    add_column :blips, :body, :text
    add_column :blips, :avatar, :text
    add_column :blips, :user, :string
    add_index :blips, :blip_id
  end

  def self.down
    remove_column :blips, :blip_id
    remove_column :blips, :body
    remove_column :blips, :user
  end
end
