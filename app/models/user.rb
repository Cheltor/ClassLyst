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
  acts_as_paranoid

  has_many :enrolls
  has_many :courses, :through => :enrolls

  has_many :rewardpurchases
  has_many :redeems

  belongs_to :university, :required => true

  def save_with_email
    if valid?
      AdminMailer.with(user: current_user).admin_email.deliver_now
      save!
    end
  end

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

  def purchase_reward(value) 
    update_attribute(:karma, karma - value)
  end
end
