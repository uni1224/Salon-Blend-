class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    belongs_to :salon
    validates :comment, presence: true
end
