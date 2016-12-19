class Shop < ApplicationRecord
  ## relations
  belongs_to :user
  ## paperclip
  has_attached_file :image, styles: {medium: '300x300>', thumb: '100x100>'}, default_url: 'https://placehold.it/150x150'
  ## validations
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :name, presence: true, uniqueness: {scope: :user_id, :case_sensitive => false}

  before_create :setSecretKey, :generateSlug
  before_update :updateSlug

  def setSecretKey
    self.secret_key = SecureRandom.hex 32
  end

  def generateSlug
    self.slug = self.name.parameterize
  end

  def updateSlug
    self.slug = self.name.parameterize
  end

  ## display data

  def to_param
    slug&.to_s
  end

  def description_param
    self[:description].blank? ? 'N/A' : self[:description]
  end
end
