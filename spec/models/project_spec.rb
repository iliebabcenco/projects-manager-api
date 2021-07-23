require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:name) { "test name" }
  it { should have_many(:comments).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:images) }
  it { should validate_presence_of(:created_by) }
end
