class User < ApplicationRecord
  has_secure_password
  has_many :projects, foreign_key: :created_by
  validates_presence_of :name, :email, :password_digest
end
