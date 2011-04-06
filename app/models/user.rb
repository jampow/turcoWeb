class User < ActiveRecord::Base
	acts_as_authentic
	
	validates_presence_of :username
	validates_presence_of :password
	validates_presence_of :password_confirmation
end
