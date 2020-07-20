class Company < ApplicationRecord
  has_rich_text :description

  attribute :city, :string
  attribute :state, :string

  EMAIL_REGEX = /\A[\w+\.]+@getmainstreet.com\z/i
  validates :email, allow_blank: true,
                    format: { with: EMAIL_REGEX, message: "should have domain '@getmainstreet.com'" }

  validate :check_zip_code

  after_commit :update_address, if: :saved_change_to_zip_code?

  def check_zip_code
    return if ZipCodes.identify(self.zip_code).present?
    errors.add(:zip_code, "is not valid")
  end

  def update_address
    zip_code = ZipCodes.identify(self.zip_code)
    if zip_code.present?
      self.city = zip_code[:city]
      self.state = zip_code[:state_code]
      Rails.cache.write("#{self.id}_city", city)
      Rails.cache.write("#{self.id}_state", state)
    end
  end

  def get_address
    self.city = Rails.cache.read("#{self.id}_city")
    self.state = Rails.cache.read("#{self.id}_state")
    update_address
  end
end
