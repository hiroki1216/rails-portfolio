class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :talk, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
    add_index :messages, [:updated_at, :talk_id]
  end
end
