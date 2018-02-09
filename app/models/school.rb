class School < ApplicationRecord
  validates_presence_of :name, :username, :password_digest
  validates :username, uniqueness: true

  #encrypt password
  has_secure_password
end
