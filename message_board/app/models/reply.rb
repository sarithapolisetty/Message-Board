class Reply < ApplicationRecord

  belongs_to :user
  
  belongs_to :message, optional: true

  validates :content, presence: true

end
