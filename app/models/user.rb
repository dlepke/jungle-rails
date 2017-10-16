class User < ActiveRecord::Base
    has_secure_password
    validates_uniqueness_of :email
    has_many :reviews
    
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :password, presence: true, length: { minimum: 5 }
    validates :password_confirmation, presence: true

    def self.authenticate_with_credentials(email, pw)
        user = User.find_by_email(email)

        if user && user.authenticate(pw)
            user
        else
            nil
        end
    end
end