class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_many :follower_relationships,class_name:"Relationship",foreign_key:"follower_id",dependent: :destroy
  has_many :followers ,through: :followers_relationship, source: :followed

  has_many :followed_relationships,class_name:"Relationship",foreign_key:"followed_id",dependent: :destroy
  has_many :followeds ,through: :followeds_relationship, source: :follower
  
  attachment :profile_image

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  def followers_by?(user)
    follower_relationships.where(follower_id: user.id).exists?
  end

end
