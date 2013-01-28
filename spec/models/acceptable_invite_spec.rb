require 'spec_helper'

describe AcceptableInvite do
  context "#valid?" do
    it { should ensure_inclusion_of(:state).in_array(%w(pending noreply attending maybe declined)) }
  end
end
