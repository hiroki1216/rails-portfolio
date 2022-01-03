class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :visitor, foreign_key: { to_table: :users }
      t.references :visited, foreign_key: { to_table: :users }
      t.references :action, polymorphic: true
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
    add_index :notifications, [:action_id, :action_type]
  end
end
