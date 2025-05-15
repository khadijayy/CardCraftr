class CreateCardTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :card_templates do |t|
      t.string :title

      t.timestamps
    end
  end
end
