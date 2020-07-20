class Company < ApplicationRecord
  has_rich_text :description

  EMAIL_REGEX = /\A[\w+\.]+@getmainstreet.com\z/i
  validates :email, allow_blank: true,
                    format: { with: EMAIL_REGEX, message: "should have domain '@getmainstreet.com'" }
end
