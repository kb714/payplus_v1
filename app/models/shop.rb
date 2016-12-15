class Shop < ApplicationRecord
  ## relations
  belongs_to :user

  ## validations
  validates :name, presence: true, uniqueness: true

  before_create :setSecretKey

  def setSecretKey
    self.secret_key = SecureRandom.hex 32
  end
end
