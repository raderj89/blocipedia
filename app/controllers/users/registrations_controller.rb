class Users::RegistrationsController < Devise::RegistrationsController
before_filter :setup, only: [:edit]
  
  def update_plan
    @user = current_user
    @user.update_attributes(plan_id: params[:plan], email: params[:email], stripe_card_token: params[:user][:stripe_card_token])
      if @user.plan_id == 2
        @user.update_user_plan
        redirect_to edit_user_registration_path, notice: "Updated plan!"
      else
        flash[:error] = "Unable to update plan."
        render :edit
      end
    binding.pry
  end

  private

  def build_resource(*args)
    super
    if params[:plan]
      resource.plan_id = params[:plan]
      if resource.plan_id == 2
        resource.save_with_payment
      else
        resource.save
      end
      binding.pry
    end
  end

  def setup
    plans = Plan.all
    plans.each do |plan|
      unless plan.id == 1
        @premium_plan = plan
      end
    end
  end
end