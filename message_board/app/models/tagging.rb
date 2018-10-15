class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :message

  validates :message_id, uniqueness: { scope: :tag_id }
  
end
