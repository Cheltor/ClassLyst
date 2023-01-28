class Reward < ApplicationRecord
  belongs_to :business
  has_many :rewardpurchases
  validates :expdate, presence: true
  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    if expdate.present? && expdate < Date.today
      errors.add(:expdate, "can't be in the past")
    end
  end  

  def bye
    update(byed: true)
  end

  def expired?
  	self.expdate < Date.current
  end

  def self.not_expired
    where('expdate >= ?', Date.current)
  end
end
