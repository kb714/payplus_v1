class ShopController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def create
    @shop = Shop.new
  end

  def show
  end

  def edit
  end

  private

  def secure_params
    params.permit(:id, :name, :description, :img, :url, :notify_url)
  end
end
