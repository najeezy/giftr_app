require 'rails_helper'

describe Gift do
  it { is_expected.to belong_to(:event) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:category) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:small_image_url) }
  it { is_expected.to validate_presence_of(:large_image_url) }
  it { is_expected.to validate_presence_of(:amazon_url) }
  it { is_expected.to validate_presence_of(:specifics) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:event_id) }

  it { is_expected.to validate_numericality_of(:price).is_greater_than(-1) }
  it { is_expected.to validate_numericality_of(:user_id).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:event_id).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:buyer_id).is_greater_than(0) }

  xit { is_expected.to ensure_inclusion_of(:status).in_array(%w(bought claimed cancelled)) }
end
