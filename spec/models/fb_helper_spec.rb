require 'rails_helper'

describe FBHelper do
  let(:najee) { User.create! username: 'truotaku', password: 'apple123',
                            password_confirmation: 'apple123',
                            first_name: 'Najee', last_name: 'Gardner' }
  # describe '.get_oauth_object' do
  #   xit 'should return an Oauth object' do
  #
  #   end
  # end
end
