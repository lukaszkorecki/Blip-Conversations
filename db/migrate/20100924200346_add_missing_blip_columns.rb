class AddMissingBlipColumns < ActiveRecord::Migration
  def self.up
    add_column :blips, :blip_created, :string
    add_column :blips, :body, :text
  end

  def self.down
  end
end
