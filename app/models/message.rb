class Message < ApplicationRecord
belongs_to :user, optional: true
belongs_to :salon, optional: true
belongs_to :room

validates :message, presence: true

end
