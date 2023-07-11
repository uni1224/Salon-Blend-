class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :salon
    
    validates :title, presence: true
    validates :body, presence: true
    validates :image, presence: true
    
    def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
    end
 
 
end
