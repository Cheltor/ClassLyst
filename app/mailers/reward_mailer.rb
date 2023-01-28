class RewardMailer < ApplicationMailer
  default from: 'rewards@classlyst.com'
 
  def user_reward_email
    @user = params[:user]
    @reward = params[:reward]
    @rewardpurchase = params[:rewardpurchase]
    @url  = 'https://www.classlyst.com'
    mail(to: @user.email, subject: 'Your new Classlyst Reward!')
  end

  def biz_reward_email
    @user = params[:user]
    @reward = params[:reward]
    @rewardpurchase = params[:rewardpurchase]
    @business = params[:business]
    @url  = 'https://www.classlyst.com'
    mail(to: @user.email, subject: 'New Classlyst Reward Purchased!')  	
  end
end
