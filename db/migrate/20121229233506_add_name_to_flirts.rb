class AddNameToFlirts < ActiveRecord::Migration
  def change
    add_column :flirts, :name, :string
  end
end
