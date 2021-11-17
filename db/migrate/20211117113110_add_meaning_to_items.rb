class AddMeaningToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :meaning, :string
    add_column :items, :memo, :text
  end
end
