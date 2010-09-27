class AddMissingBlipColumns < ActiveRecord::Migration
  def self.up
    add_column :blips, :blip_created, :string
  end

  def self.down
    remove_column :blips, :blip_created
  end
end
