class CreateFlirts < ActiveRecord::Migration
  def change
    create_table :flirts do |t|
      t.string :handle
      t.references :user

      t.timestamps
    end
    add_index :flirts, :user_id
  end
end
