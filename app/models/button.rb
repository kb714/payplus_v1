class Button < ApplicationRecord
  include Rails.application.routes.url_helpers
  ## relations
  belongs_to :shop

  ## validations
  validates :name, presence: true, uniqueness: {scope: :shop_id}
  validates_numericality_of :stock, presence: true, greater_than: 0, only_integer: true, if: 'is_stock?'
  validates_numericality_of :price, only_integer: true
  validates_numericality_of :price, greater_than: 500, if: 'price > 0'
  validates_numericality_of :charge, only_integer: true

  before_create :generate_slug, :generate_qr
  before_update :update_slug
  before_destroy :destroy_qr

  ## before_create
  def generate_slug
    self.button_slug = self.name.parameterize
  end

  def generate_qr
    path = "#{Rails.root}/public/shops/#{self.shop_id}/buttons/"
    FileUtils.mkdir_p(path) unless File.directory?(path)
    qr = RQRCode::QRCode.new(create_webpay_button_url(shop_id: self.shop.id, button_slug: self.button_slug))
    qr.as_png(file: "#{path}#{self.name.parameterize}.png")
    self.qr = "/shops/#{self.shop_id}/buttons/#{self.name.parameterize}.png"
  end

  ## before_update
  def update_slug
    self.button_slug = self.name.parameterize
  end

  ## before_destroy
  def destroy_qr
    File.delete("#{Rails.root}/public#{self.qr}")
  end

  ## display data
  def to_param
    button_slug.to_s
  end

  def description_param
    self[:description].blank? ? 'N/A' : self[:description]
  end

  def price_param
    self[:price].to_i == 0 ? 'Variable' : self[:price]
  end

  def is_stock_param
    self[:is_stock] ? 'Si' : 'No'
  end

  def charge_param
    self[:charge].to_i == 0 ? 'Sin cargo' : self[:charge]
  end
end
