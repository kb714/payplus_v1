class Shop::ButtonController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  before_action :current_shop

  def index
    @buttons = @shop.buttons
  end

  def new
    @button = @shop.buttons.new
  end

  def create
    @button = @shop.buttons.new(secure_params)
    if @button.valid?
      @button.save
      redirect_to button_index_path
    else
      render action: :new
    end
  end

  def show
    @button = @shop.buttons.find_by(button_slug: params[:button_slug])
  end

  def edit
    @button = @shop.buttons.find_by(button_slug: params[:button_slug])
  end

  def update
    @button = @shop.buttons.find_by(button_slug: params[:button_slug])

    if @button.update(secure_params)
      redirect_to button_path(@shop, @button)
    else
      render 'edit'
    end
  end

  def destroy
    @button = @shop.buttons.find_by(button_slug: params[:button_slug])

    if @button.destroy
      redirect_to button_index_path
    else
      render 'show'
    end
  end

  private

  def secure_params
    params.require(:button).permit(:name, :description, :price, :charge, :is_stock, :stock)
  end

  def current_shop
    @section = {title: 'Botones de pago', icon: 'credit-card'}
    @shop = current_user.shops.find_by(slug: params[:slug])
  end
end
