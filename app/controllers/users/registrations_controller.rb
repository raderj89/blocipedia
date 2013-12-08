class Users::RegistrationsController < Devise::RegistrationsController

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
    end
  end
end