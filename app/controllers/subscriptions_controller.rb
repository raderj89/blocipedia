class SubscriptionsController < ApplicationController
  before_filter :authenticate_user! # TODO: let user know they still need to confirm their account
  before_filter :setup

def new
    @subscription = current_user.build_subscription
  end

  def create
    @plan_id = params[:plan_id]
    if @plan_id == 2
      @subscription = current_user.create_subscription(plan_id: @plan_id, stripe_card_token: params[:stripe_card_token])
      if @subscription.save_with_payment
        flash[:success] = "You're signed up with the #{@subscription.plan.name} plan!"
        redirect_to root_path
      else
        flash[:notice] = "There was an error."
        render :new
      end
    else
      @subscription = current_user.create_subscription(plan_id: @plan_id)
      flash[:success] = "You're signed up with the #{@subscription.plan.name} plan!"
      redirect_to root_path
    end
  end

  private

  def setup
    @plans = Plan.all

    @plans.each do |plan|
      if plan.id == 1
        @free_plan = plan
      else
        @premium_plan = plan
      end
    end
    #binding.pry
  end

end
