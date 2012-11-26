class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :provider
      t.string :handle
      t.references :user

      t.timestamps
    end
    add_index :links, :user_id
  end
end
