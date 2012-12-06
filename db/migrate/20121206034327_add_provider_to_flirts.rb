class AddProviderToFlirts < ActiveRecord::Migration
  def change
    add_column :flirts, :provider, :string
  end
end
