require 'rails_helper'

describe Amazon do

  describe '.amazon_search' do
    let(:result) { Amazon.amazon_search('playstation 4') }

    it 'should return a hash object' do
      expect(result.is_a?(Hash)).to eq(true)
    end

    it 'should have an ItemSearchResponse key' do
      expect(result['ItemSearchResponse']).to be
    end

    it 'should have an Items key in the value of ItemSearchResponse key' do
      expect(result['ItemSearchResponse']['Items']).to be
    end

    it 'should have an Item key for value of Items key which is in value of ItemSearchResponse' do
      expect(result['ItemSearchResponse']['Items']['Item']).to be
    end

    it 'should have a hash with a nested Item key that has array as value' do
      expect(result['ItemSearchResponse']['Items']['Item'].is_a?(Array)).to eq(true)
    end

    it 'should have at least 10 elements as a value for Item key' do
      expect(result['ItemSearchResponse']['Items']['Item']).to have_at_least(10).items
    end
  end

  describe '.search' do
    let(:result) { Amazon.search('playstation 4') }
    it 'should return an array' do
      expect(result.is_a?(Array)).to eq(true)
    end

    it 'should have name, category, price, small_image_url, large_image_url and amazon_url keys that point to values' do
      keys = [:name, :category, :price, :small_image_url, :large_image_url, :amazon_url]
      result.each do |item|
        keys.each do |key|
          expect(item[key]).to be
        end
      end
    end

  end
end
