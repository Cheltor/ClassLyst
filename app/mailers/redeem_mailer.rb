class RedeemMailer < ApplicationMailer
  default from: 'rewards@classlyst.com'

  def biz_redeem_email
    @user = params[:user]
    @rewardpurchase = params[:rewardpurchase]
    @business = params[:business]
    @url  = 'https://www.classlyst.com'
    mail(to: @user.email, subject: 'New Classlyst Reward Redeemed!')  	
  end
end
