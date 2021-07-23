require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:name) { "test name" }
  it { should belong_to(:project) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:likes) }
end
