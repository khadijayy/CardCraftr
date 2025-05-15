class CreateTemplates < ActiveRecord::Migration[8.0]
  def up
    create_table :templates do |t|
      t.string :title
      t.string :image
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
  def down
    drop_table :templates
  end
end
