class Project < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates_presence_of :title, :description, :created_by, :likes
end
