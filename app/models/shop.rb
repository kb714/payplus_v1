class Shop < ApplicationRecord
  ## relations
  belongs_to :user

  ## validations
  validates :name, presence: true, uniqueness: {scope: :user_id}

  before_create :setSecretKey, :generateSlug

  def setSecretKey
    self.secret_key = SecureRandom.hex 32
  end

  def generateSlug
    self.slug = self.name.parameterize
  end
end
