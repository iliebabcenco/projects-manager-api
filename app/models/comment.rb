class Comment < ApplicationRecord
  belongs_to :project
  validates_presence_of :content, :likes
end
