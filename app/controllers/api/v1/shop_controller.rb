class Api::V1::ShopController < ApplicationController
  def Shop
  end

  def store
    data = current_user.shops.new(secure_params)
    if data.valid?
      data.save
      render json: data
    else
      render json: data.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def secure_params
    params.require(:shop).permit(:id, :name, :description)
  end
end
