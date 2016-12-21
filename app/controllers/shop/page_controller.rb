class Shop::PageController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  before_action :current_shop

  def index

  end

  private

  def current_shop
    @section = {title: 'Página de cobro', icon: 'file-o'}
    @shop = current_user.shops.find_by(slug: params[:slug])
  end
end
