require 'spec_helper'

describe User do
  let(:user) { build(:user) }
  let(:event) { user.created_events.build }

  it { should have_many(:created_events).dependent(:destroy) }

  context "#valid?" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:oauth_token) }

    it { should validate_presence_of(:uid) }
    it { should validate_numericality_of(:uid) }
    it { should validate_uniqueness_of(:uid) }

    it { should validate_format_of(:provider).with('facebook') }
    it { should validate_format_of(:provider).not_with('twitter') }
  end
end