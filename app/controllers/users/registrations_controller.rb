class Users::RegistrationsController < Devise::RegistrationsController
before_filter :setup
  # def new
  #   super
  #   @user = User.new(plan_id: params[:plan])
  #   binding.pry
  # end

  # def new
  #   @user = User.new(plan_id: params[:plan])
  #   if @user
  #     super
  #   else
  #     redirect_to root_path, :notice => 'Please select a subscription plan below.'
  #   end
  #   binding.pry
  # end

  def create
    build_resource(sign_up_params)
    resource.plan_id = params[:plan].to_i
    if resource.save_with_payment
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # def create
  #   build_resource(sign_up_params)

  #   if resource.save
  #     if resource.active_for_authentication?
  #       set_flash_message :notice, :signed_up if is_navigational_format?
  #       sign_up(resource_name, resource)
  #   if params[:plan] == 2
  #     resource.save_with_payment
  #     if resource.save
  #       flash[:success] = "You're signed up with the Premium plan!"
  #       redirect_to root_path
  #     else
  #       flash[:notice] = "There was an error."
  #       render :new
  #     end
  #   else
  #     if resource.save
  #       flash[:success] = "You're signed up with the Free plan!"
  #       redirect_to root_path
  #     else
  #       flash[:notice] = "There was an error."
  #       render :new        
  #     end
  #   end
  # end

  # private

  # def build_resource(*args)
  #   super
  #   if params[:plan]
  #     resource.plan(params[:plan])
  #   end
  # end

  protected

  # def after_sign_up_path_for(resource)
  #   new_user_subscription_path(resource)
  # end

  def setup
    if params[:plan] == "1"
      @plan = Plan.find(1)
    else
      @plan = Plan.find(2)
    end
  end
end