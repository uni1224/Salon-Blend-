class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :salon#,optional: true
    has_many :comments, dependent: :destroy
    has_many :likes
    
    def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
    end
 
    validates :title, presence: true
    validates :body, presence: true
    validates :image, presence: true
    
end
