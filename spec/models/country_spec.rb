require 'rails_helper'

RSpec.describe Country, type: :model do
  it { is_expected.to validate_presence_of(:name) }
end
