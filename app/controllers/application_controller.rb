class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_shops

  private

  def set_shops
    @shops = Shop.where(:user_id => current_user.id).all if user_signed_in?
  end
end
