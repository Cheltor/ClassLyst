class RewardMailer < ApplicationMailer
  default from: 'rewards@classlyst.com'
 
  def user_reward_email
    @user = params[:user]
    @reward = params[:reward]
    @rewardpurchase = params[:rewardpurchase]
    @url  = 'https://classlyst.com/myrewards'
    mail(to: @user.email, subject: 'New Classlyst Reward!')
  end
end
