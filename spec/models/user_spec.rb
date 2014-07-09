require 'rails_helper'

describe User do
  let(:najee) { User.create! username: 'truotaku', password: 'apple123',
                            password_confirmation: 'apple123',
                            first_name: 'Najee', last_name: 'Gardner' }

  it { expect(najee).to be_valid }

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:password_confirmation) }
  it { is_expected.to ensure_length_of(:password).is_at_least(8) }
  it { is_expected.to have_secure_password }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

end
