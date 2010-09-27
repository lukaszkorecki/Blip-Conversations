class Jsonify < ActiveRecord::Migration
  def self.up
    [:avatar, :blip_created, :body, :user].each do | name|
      remove_column :blips, name
    end
    add_column :blips, :json, :text
  end

  def self.down
    [:avatar, :blip_created, :body, :user].each do |name|
      add_column :blips, name, :text
    end
  end
end
