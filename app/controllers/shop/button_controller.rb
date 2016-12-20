class Shop::ButtonController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
    @section = {title: 'Botones de pago', icon: 'credit-card'}
    @shop = current_user.shops.find_by(slug: params[:slug])
  end

  def new
    @section = {title: 'Botones de pago', icon: 'credit-card'}
    @shop = current_user.shops.find_by(slug: params[:slug])
    @button = @shop.buttons.new
  end
end
