class User < ActiveRecord::Base
	acts_as_authentic

	attr_accessor :password_confirmation

	validates_presence_of :username
	validates_presence_of :password
end

