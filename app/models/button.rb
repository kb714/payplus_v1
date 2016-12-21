class Button < ApplicationRecord
  ## relations
  belongs_to :shop

  ## validations
  validates :name, presence: true, uniqueness: {scope: :shop_id}
  validates_numericality_of :price, only_integer: true, if: 'price.present?'

  before_create :generate_slug
  before_update :update_slug

  def generate_slug
    self.button_slug = self.name.parameterize
  end

  def update_slug
    self.button_slug = self.name.parameterize
  end

  def to_param
    button_slug.to_s
  end

  def description_param
    self[:description].blank? ? 'N/A' : self[:description]
  end

  def is_stock_param
    self[:is_stock] ? 'Si' : 'No'
  end

  def charge_param
    self[:charge].to_i == 0 ? 'Sin cargo' : self[:charge]
  end
end
