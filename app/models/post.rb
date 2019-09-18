class Post < ApplicationRecord
  acts_as_paranoid
  acts_as_votable
  belongs_to :user
  belongs_to :course
  belongs_to :ptype
  has_many :comments, as: :commentable

  def flag
    update(flagged: true)
  end

  def useranon
  	if @post.user.anon_id == 1
      "#{post.user.email}"
  	else
  	  "anon"
  	end
  end
end
