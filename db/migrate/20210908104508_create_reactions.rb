class CreateReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :reactions do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :statement, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reactions, [:user_id, :statement_id, :created_at]
  end
end
