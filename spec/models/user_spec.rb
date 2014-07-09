require 'rails_helper'

describe User do
  let(:najee) { User.create! username: 'truotaku', password: 'apple123',
                            password_confirmation: 'apple123',
                            first_name: 'Najee', last_name: 'Gardner',
                            facebook_id: 10204641147254238,
                            fb_access_token: 'CAAEV3E7VLYQBABkBc7qO5cuPB6ZCiCfZCWQNiHKyYC5iZAzIukfiZCO0MYTf6tRYH61AjDtDZCVUYckjr9Wzf5KZAjpaWL82OaR5PLG520Bd3ZBEPJZBXAQ5Hz6tl0nQxSNKC4MBLxxwvnudCO2w6fmGZAldE2AJUCkVZBfa3vFZBOSj3Q2Cf6VL3pNKPdpNZC5WGjoZD'}

  let(:alex) { User.create! username: 'alevine', password: 'apple123',
                            password_confirmation: 'apple123',
                            first_name: 'Alex', last_name: 'Levine',
                            facebook_id: 857544726418 }

  let(:james) { User.create! username: 'jliu', password: 'apple123',
                            password_confirmation: 'apple123',
                            first_name: 'James', last_name: 'Liu',
                            facebook_id: 10152130158967484 }

  it { expect(najee).to be_valid }

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:password_confirmation) }
  it { is_expected.to ensure_length_of(:password).is_at_least(8) }
  it { is_expected.to have_secure_password }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  # describe '#suggested friends' do
  #
    # it 'should return an array of User objects' do
    #   najee.suggested_friends.each do |friend|
    #     expect(friend.is_a?(User)).to eq(true)
    #   end
    # end
  # end

  describe '#update_profile_image' do

    it 'should change the small and large image url attirbutes' do
      najee.update_profile_image
      expect(najee.small_image_url).to be
      expect(najee.large_image_url).to be
    end
  end

  describe '#update_fb_id' do

    it 'should add the facebook_id when there is none' do
      najee.update_attribute(:facebook_id, nil)
      expect(najee.facebook_id).to be_nil
      najee.update_fb_id
      expect(najee.facebook_id).to be
    end
  end

  describe '#update_fb_attributes' do

    it 'should update the small_image_url, large_image_url, and facebook_id' do
      najee.update_attribute(:facebook_id, nil)
      expect(najee.facebook_id).to be_nil
      najee.update_fb_attributes
      expect(najee.facebook_id).to be
      expect(najee.small_image_url).to be
      expect(najee.large_image_url).to be
    end
  end
end
