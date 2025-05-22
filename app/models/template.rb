class Template < ApplicationRecord
  belongs_to :category
  has_one_attached :image 
  has_many :customized_cards, dependent: :destroy
end
