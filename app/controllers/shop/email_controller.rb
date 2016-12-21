class Shop::EmailController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  before_action :current_shop

  def index

  end

  private

  def current_shop
    @section = {title: 'Cobros por email', icon: 'envelope-o'}
    @shop = current_user.shops.find_by(slug: params[:slug])
  end
end
