class RewardsController < ApplicationController
  before_action :set_reward, only: [:show, :edit, :update, :destroy, :bye]
  before_action :authenticate_business!, :except => [:index, :show, :rewardpurchase]
  before_action :authorized_business, only: [:edit, :update]
  before_action :authenticate_user!, only: [:rewardpurchase]

   def valid
  end

  def bye
    @reward.bye
    redirect_to @reward
  end

   def show
    @rewardpurchase = Rewardpurchase.find(params[:id])
  end

  # GET /rewards/myrewards
  # GET /rewards/myrewards.json
  def myrewards
    @rewards = Reward.all.where(business: current_business).where(byed: false)
  end

  # GET /rewards
  # GET /rewards.json
  def index
    @rewards = Reward.not_expired.where(byed: false)
  end

  # GET /rewards/1
  # GET /rewards/1.json
  def show
  end

  # GET /rewards/new
  def new
    @reward = current_business.rewards.build
  end

  # GET /rewards/1/edit
  def edit
  end

  # POST /rewards
  # POST /rewards.json
  def create
    @reward = current_business.rewards.build(reward_params)

    respond_to do |format|
      if @reward.save
        format.html { redirect_to @reward, notice: 'Reward was successfully created.' }
        format.json { render :show, status: :created, location: @reward }
      else
        format.html { render :new }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rewards/1
  # PATCH/PUT /rewards/1.json
  def update
    respond_to do |format|
      if @reward.update(reward_params)
        format.html { redirect_to @reward, notice: 'Reward was successfully updated.' }
        format.json { render :show, status: :ok, location: @reward }
      else
        format.html { render :edit }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rewards/1
  # DELETE /rewards/1.json
  def destroy
    @reward.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Reward was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /purchase
  # POST /purchase.json
  def rewardpurchase
    @reward = Reward.find(params[:id]).clone
    @rewardpurchase = @reward.rewardpurchases.create(params.permit(:reward_id,:user_id,:rewardname,:rewardbusiness,:rewardcost))
    @rewardpurchase.rewardname = @reward.name.dup
    @rewardpurchase.rewardbusiness = @reward.business.name.dup
    @rewardpurchase.bizemail = @reward.business.email.dup
    @rewardpurchase.rewardcost = @reward.cost.to_s.dup
    @rewardpurchase.rewardexp = @reward.expdate.dup
    @rewardpurchase.user_id = current_user.id

       respond_to do |format|
        if @rewardpurchase.save
          current_user.purchase_reward(@reward.cost)
          RewardMailer.with(user: current_user, reward: @reward, rewardpurchase: @rewardpurchase).user_reward_email.deliver_now
          RewardMailer.with(user: current_user, reward: @reward, rewardpurchase: @rewardpurchase, business: @reward.business).biz_reward_email.deliver_now          
          format.html { redirect_to root_url, notice: 'Reward was successfully purchased!' }
          format.json { render json: @rewardpurchase, status: :created, location: @rewardpurchase }
        else
          format.html { redirect_to @reward}
          format.json { render json: @rewardpurchase.errors, status: :unprocessable_entity }
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reward
      @reward = Reward.find(params[:id])
    end

    # Security
    def authorized_business
      @reward = current_business.rewards.find_by(id: params[:id])
      redirect_to rewards_path, notice: "Not authorized to edit this reward" if @reward.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reward_params
      params.require(:reward).permit(:name, :cost, :description, :expdate)
    end
end
