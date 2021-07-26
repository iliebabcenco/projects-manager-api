require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name) { "test name" }
  it { should have_many(:projects) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
