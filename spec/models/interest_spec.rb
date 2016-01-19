require 'rails_helper'

RSpec.describe Interest, type: :model do
  it { is_expected.to validate_presence_of(:name) }
end
