class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @subscription = Subscription.new
  end

  def create
    build_resource
    if resource.save
      if resource.active_for_authentication? 
        if params[:plan] == 2
          @subscription = Subscription.create(params[:subscription])
          if @subscription.save_with_payment
            flash[:success] = "You're signed up with the #{@subscription.plan.name} plan!"
            redirect_to root_path
          else
            flash[:notice] = "There was an error."
            render :new
          end
        else
          @subscription = Subscription.create(plan_id: params[:plan], user_id: resource.id)
        end
      end
    end
    super
  end

  # protected

  # def after_sign_up_path_for(resource)
  #   new_user_subscription_path(resource)
  # end
end