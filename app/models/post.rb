class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :menu
    def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
    end
 
 
end
