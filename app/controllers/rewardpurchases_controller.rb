class RewardpurchasesController < ApplicationController
  # POST /redeems
  # POST /redeems.json
  def redeem	  def redeem
    @rewardpurchase = Rewardpurchase.find(params[:id])
    @redeem = @rewardpurchase.redeems.create(params.permit(:rewardpurchase_id,:user_id))
    @redeem.user_id = current_user.id
    @redeem.rewardpurchase_id = @rewardpurchase.id

       respond_to do |format|
        if @redeem.save
          format.html { redirect_to valid_url, notice: 'redeem was successfully created.' }
          format.json { render json: @redeem, status: :created, location: @redeem }
        else
          format.html { redirect_to @rewardpurchase}
          format.json { render json: @redeem.errors, status: :unprocessable_entity }
        end
      end
  end

  def valid
  end

   def show
    @rewardpurchase = Rewardpurchase.find(params[:id])
  end	  end

	def myrewards
  	  @rewardpurchase = Rewardpurchase.all.where(user_id: current_user.id).where.not(id: Redeem.select(:rewardpurchase_id))
	end
end
