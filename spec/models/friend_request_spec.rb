require 'rails_helper'

describe FriendRequest do

  it { is_expected.to validate_presence_of(:sender_id) }
  it { is_expected.to validate_presence_of(:responded) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:sender_name) }

  it { is_expected.to validate_numericality_of(:sender_id).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:user_id).is_greater_than(0) }

  it { is_expected.to belong_to(:user) }

end
