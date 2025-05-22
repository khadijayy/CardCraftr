class CreateCustomizedCards < ActiveRecord::Migration[8.0]
  def change
    create_table :customized_cards do |t|
      t.string :name
      t.string :date
      t.text :message
      t.references :template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
