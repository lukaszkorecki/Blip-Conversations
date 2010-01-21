class CreateThreads < ActiveRecord::Migration
  def self.up
    create_table :threads do |t|
      t.id :int
      t.blip_id :int
      t.timestamps
    end
  end

  def self.down
    drop_table :threads
  end
end
