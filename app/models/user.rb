class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  # Only emails ending in .edu can registar (to avoid spam and keep accountability)
  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[e]+[d]+[u]\z/i
  has_many :posts

  acts_as_voter

  has_many :enrolls
  has_many :courses, :through => :enrolls

  has_many :rewardpurchases

  def increase_karma(count=1)
    update_attribute(:karma, karma + count)
  end

  def decrease_karma(count=1)
    update_attribute(:karma, karma - count)
  end

  def increase_reputation(count=1)
  	update_attribute(:reputation, reputation + count)
  end

  def decrease_reputation(count=1)
  	update_attribute(:reputation, reputation - count)
  end
end
