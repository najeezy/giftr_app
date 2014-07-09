require 'rails_helper'

describe Friendship do

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:friend_id) }

  it { is_expected.to validate_numericality_of(:user_id) }
  it { is_expected.to validate_numericality_of(:friend_id) }
end
