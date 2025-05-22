class FixCustomizedCardsTemplateRelation < ActiveRecord::Migration[6.1]
  def change
    # Remove unique index if it exists
    remove_index :customized_cards, :template_id if index_exists?(:customized_cards, :template_id, unique: true)

    # Remove foreign key safely
    remove_foreign_key :customized_cards, column: :template_id rescue nil

    # Add proper foreign key (many-to-one)
    add_foreign_key :customized_cards, :templates, column: :template_id

    # Add regular (non-unique) index if needed
    add_index :customized_cards, :template_id unless index_exists?(:customized_cards, :template_id)
  end
end
