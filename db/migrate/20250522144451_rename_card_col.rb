class RenameCardCol < ActiveRecord::Migration[8.0]
  def change
    rename_column :customized_cards, :card_template_id, :template_id
  end
end
