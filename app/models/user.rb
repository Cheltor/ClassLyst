class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  # Only emails ending in .edu can registar (to avoid spam and keep accountability)
  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[e]+[d]+[u]\z/i
end
