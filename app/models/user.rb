class User < ApplicationRecord
    before_save { self.email = email.downcase }
    # has_many :stock_port, dependent: :destroy
    validates :username, presence: true, uniqueness: { case_sensitive: false }, 
              length: { minimum: 3, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 105 },
              uniqueness: { case_sensitive: false },
              format: { with: VALID_EMAIL_REGEX }
    has_secure_password
    
    has_many :stars, class_name: "Follow", foreign_key: "follower_id"
    # has_many :stars, through: :followers
    has_many :followers, class_name: "Follow", foreign_key: "star_id"
    # has_many :followers,  through: :stars 
    has_many :freinds, class_name: "Friend", foreign_key: "freind1_id"
    has_many :freinds, class_name: "Friend", foreign_key: "freind2_id"
    #  has_many :freinds , through: :freinds
   
end