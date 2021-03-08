class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # has_many :follower_relationships,class_name:"Relationship",foreign_key:"follower_id",dependent: :destroy
  # has_many :followers ,through: :follower_relationships, source: :followed

  # has_many :followed_relationships,class_name:"Relationship",foreign_key:"followed_id",dependent: :destroy
  # has_many :followeds ,through: :followed_relationships, source: :follower
  
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  
  attachment :profile_image

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  # def followers_by?(user)
  #   follower_relationships.include?(follower_id: user.id)
  # end
  
def follow(user_id)
  follower.create(followed_id: user_id)
end

def unfollow(user_id)
  follower.find_by(followed_id: user_id).destroy
end

def following?(user)
  following_user.include?(user)
end

    def self.search(method,word)
      if method == "forward_match"
    @users = User.where("name LIKE?","#{word}%")
      elsif method == "backward_match"
    @users = User.where("name LIKE?","%#{word}")
      elsif method == "perfect_match"
    @users = User.where("#{word}")
      elsif method == "partial_match"
    @users = User.where("name LIKE?","%#{word}%")
      else
    @users = User.all
      end
    end

end
