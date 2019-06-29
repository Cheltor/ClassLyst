class AdminRegistrationsController < Devise::RegistrationsController

  def create
    super
	if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 1
          resource.save
        else
          resource.save_with_email
        end
      end
  end

end