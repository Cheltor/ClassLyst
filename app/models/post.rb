class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  belongs_to :course
  belongs_to :ptype
  validates_format_of :url, :with => /\A^https?+.{1,}\z/i, :allow_blank => true
  has_many :comments, as: :commentable

  def flag
    update(flagged: true)
  end
end
