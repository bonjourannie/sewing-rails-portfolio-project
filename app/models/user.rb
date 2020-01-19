class User < ApplicationRecord
    has_many :projects 

    has_secure_password 

    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    validates_presence_of :name, :email
    validates_uniqueness_of :email
    validates :password, presence: true, :length => {minimum: 6}

end
