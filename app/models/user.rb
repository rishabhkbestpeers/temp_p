class User < ApplicationRecord
    has_many :movies, :through => :reviews
    has_many :reviews, dependent: :destroy

    enum :role, {normal:'normal', admin: 'admin'}
    
    has_secure_password

    # validates :role, presence: true
    validates :username, presence: true, uniqueness: {message: 'Username is Already Exist'},
    length: {minimum: 5, maximum: 20}
    validates :password, length: {in: 5..15}, on: :create
    
    validates :email, 
	  format: { with: /\A(.+)@(.+)\z/, message: "Email invalid or password"  },
        uniqueness: { case_sensitive: false },
        presence: true,
        length: { minimum: 4, maximum: 30, too_long: "%{count} characters is maximum allowed", 
        too_short: "%{count} characters is minimum allowed"
    }
    
    def admin?
        role == 'admin'
    end
    def normal?
        role == 'normal'
    end
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "email", "id", "id_value", "password_digest", "role", "updated_at", "username"]
    end
end