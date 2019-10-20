class HomeController < ApplicationController
  def index
    if user_signed_in?
	  @enrolls = Enroll.all.where(user: current_user).order("created_at DESC")
	  @posts = Post.all
      @myposts = Post.all.where(user: current_user).order("created_at DESC")
      @comments = Comment.all
      @mycomments = Comment.all.where(user: current_user).order("created_at DESC")
      @rewards = Rewardpurchase.all
      @myrewards = Rewardpurchase.all.where(user: current_user).where.not(id: Redeem.select(:rewardpurchase_id))
    elsif business_signed_in?
      @rewards = Reward.all.where(byed: false)
      @myrewards = Reward.all.where(business: current_business).where(byed: false)
    else
      @search = Post.ransack(params[:q])
      @posts = @search.result.includes(:comments).order("created_at DESC")
      @rewards = Reward.not_expired.where(byed: false).order("created_at DESC")
    end
  end  

  def businessinfo
  end

  def profsignup
    # @admin = Plan.find(1)
  end

  def userpage
    @users = User.all
  end

  def landingpage
    render :layout => false
  end

  def businessesindex
    @search = Business.ransack(params[:q])
    @businesses = @search.result.paginate(page: params[:page], per_page: 15)
  end

  def businessshow
    @business = Business.find(params[:id])
  end
end
