class CreateBlips < ActiveRecord::Migration
  def self.up
    create_table :blips do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :blips
  end
end
