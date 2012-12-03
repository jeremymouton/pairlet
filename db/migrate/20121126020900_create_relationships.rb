class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :flirter_id
      t.integer :flirted_id

      t.timestamps
    end

    add_index :relationships, :flirter_id
    add_index :relationships, :flirted_id
    add_index :relationships, [:flirter_id, :flirted_id], unique: true
  end
end
