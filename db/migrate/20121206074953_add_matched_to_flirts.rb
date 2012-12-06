class AddMatchedToFlirts < ActiveRecord::Migration
  def change
    add_column :flirts, :matched, :boolean
  end
end
