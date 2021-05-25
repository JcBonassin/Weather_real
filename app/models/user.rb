class User < ActiveRecord::Base
    has_many  :locations
    
    has_secure_password
end 