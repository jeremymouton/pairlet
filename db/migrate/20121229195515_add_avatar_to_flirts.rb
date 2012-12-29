class AddAvatarToFlirts < ActiveRecord::Migration
  def change
    add_column :flirts, :avatar, :string
  end
end
