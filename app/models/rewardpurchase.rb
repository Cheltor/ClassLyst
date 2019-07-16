class Rewardpurchase < ApplicationRecord
  belongs_to :reward
  belongs_to :user
  has_many :redeems

  def self.not_expired
    where('rewardexp >= ?', Date.current)
  end
end
