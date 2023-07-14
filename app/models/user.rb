class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :reservation, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :likes,dependent: :destroy
         has_many :messages, dependent: :destroy

         scope :only_active, -> { where(is_deleted: false) }

         # 以下を追加
  def self.guest
    find_or_create_by!(last_name: "ゲスト",
                      first_name: "ゲスト",
                      last_name_kana: "ゲスト",
                      first_name_kana: "ゲスト",
                      postal_code: "0000000",
                      phone_number: "0000000000",
                      address: "ゲスト",
                      email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end
 
def liked_by?(post_id)
  likes.where(post_id: post_id).exists?  
end

def user_name
    last_name + first_name
end

    def self.looks(search, word)
      @users = User.where("first_name LIKE? OR last_name LIKE? OR first_name_kana LIKE? OR last_name_kana LIKE? OR phone_number LIKE? OR address LIKE? OR email LIKE?",
      "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%")
    end




  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :email, presence: true, uniqueness: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
end
