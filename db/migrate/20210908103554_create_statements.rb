class CreateStatements < ActiveRecord::Migration[6.0]
  def change
    create_table :statements do |t|
      t.text :content

      t.timestamps
    end
  end
end
