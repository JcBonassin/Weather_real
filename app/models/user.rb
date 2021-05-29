class User < ActiveRecord::Base
    has_many  :locations
    
    has_secure_password
    validates_presence_of :username, :name, :surname, :email, :password_digest
end 