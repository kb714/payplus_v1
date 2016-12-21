class ShopController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def new
    @section = {title: 'Creando nuevo comercio', icon: 'plus'}
    @shop = Shop.new
  end

  def create
    @shop = current_user.shops.new(secure_params)
    if @shop.valid?
      @shop.save
      redirect_to @shop
    else
      render action: :new
    end
  end

  def edit
    @section = {title: 'Editanto comercio', icon: 'pencil-square-o'}
    @shop = current_user.shops.find_by(slug: params[:slug])
  end

  def show
    @section = {title: 'Servicios asociados', icon: 'globe'}
    @shop = current_user.shops.find_by(slug: params[:slug])
    #qr = RQRCode::QRCode.new("https://www.payplus.cl/")
    #qr.as_png(file: "#{Rails.root}/public/payplus.png")
  end

  def update
    @shop = current_user.shops.find_by(slug: params[:slug])

    if @shop.update(secure_params)
      redirect_to @shop
    else
      render 'edit'
    end
  end

  def destroy
    @shop = current_user.shops.find_by(slug: params[:slug])

    if @shop.destroy
      redirect_to root_path
    else
      render 'show'
    end
  end

  private

  def secure_params
    params.require(:shop).permit(:id, :name, :description, :image, :url, :notify_url)
  end
end
