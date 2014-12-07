class RegistrationsController < Devise::RegistrationsController
  def destroy
    Rating.where(user_id: current_user.id).destroy_all
    super
  end
end