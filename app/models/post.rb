class Post < ApplicationRecord
    has_one_attached :image
    
    belongs_to :salon
    
 
end
