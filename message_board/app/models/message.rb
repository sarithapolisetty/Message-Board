class Message < ApplicationRecord
    belongs_to :user

    has_many :taggings, dependent: :destroy
  
    has_many :tags, through: :taggings

    has_many :likes, dependent: :destroy

    has_many :likers, through: :likes, source: :user
    
    has_many :replies, dependent: :destroy

    validates :title, presence: true, uniqueness: true
    
    validates :description, presence: true, length: { minimum: 20  }

    has_one_attached :image
end
