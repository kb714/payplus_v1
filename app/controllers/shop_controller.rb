class ShopController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def new
    @shop = Shop.new
  end

  def create
    @shop = current_user.shops.new(secure_params)
    if @shop.valid?
      @shop.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @shop = current_user.shops.find_by(slug: params[:slug])
  end

  def edit
  end

  private

  def secure_params
    params.require(:shop).permit(:id, :name, :slug, :description, :img, :url, :notify_url)
  end
end
