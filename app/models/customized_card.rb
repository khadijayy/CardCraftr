class CustomizedCard < ApplicationRecord
  belongs_to :template
  has_one_attached :final_image
end
