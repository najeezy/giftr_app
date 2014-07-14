require 'rails_helper'

describe Event do

  it { is_expected.to have_many(:gifts) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:user_id) }

  it { is_expected.to validate_numericality_of(:user_id).is_greater_than(0) }

  xit { is_expected.to allow_value(:date).for(/(0[1-9]|1[012])[- \/.](0[1-9]|[12][0-9]|3[01])[- \/.]\d\d\d\d/) }

end
