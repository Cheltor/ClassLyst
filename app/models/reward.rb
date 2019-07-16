class Reward < ApplicationRecord
  belongs_to :business
  has_many :rewardpurchases
  validates :expdate, presence: true


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
