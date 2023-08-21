class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservation, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :read_counts, dependent: :destroy

  scope :only_active, -> { where(is_deleted: false) }

  def self.guest
    find_or_create_by!(last_name: 'ゲスト',
                       first_name: 'ゲスト',
                       last_name_kana: 'ゲスト',
                       first_name_kana: 'ゲスト',
                       nick_name: 'ゲスト',
                       birthday: '20000101',
                       postal_code: '0000000',
                       phone_number: '0000000000',
                       address: 'ゲスト',
                       email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def liked_by?(post_id)
    likes.where(post_id:).exists?
  end

  def user_name
    last_name + first_name
  end

  def self.looks(_search, word)
    @users = User.where('first_name LIKE? OR last_name LIKE? OR first_name_kana LIKE? OR last_name_kana LIKE? OR phone_number LIKE? OR address LIKE? OR email LIKE?',
                        "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%")
  end

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  # validates :nick_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
