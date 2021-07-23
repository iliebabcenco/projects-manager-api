class Project < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates_presence_of :title, :description, :images, :created_by
end
