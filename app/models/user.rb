class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  enum genders: {male: "male", female: "female"}

  before_save :downcase_email

  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :email, presence: true, length: {maximum: Settings.email.maximum},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: Settings.password.minimum}
  validates :age, presence: true,
    numericality: {less_than_or_equal_to: Settings.age.maximum,
                   greater_than_or_equal_to: Settings.age.minimum}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
