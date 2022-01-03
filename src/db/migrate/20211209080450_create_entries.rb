class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :talk, null: false, foreign_key: true

      t.timestamps
    end
    add_index :entries, [:user_id, :talk_id], unique: true
  end
end
