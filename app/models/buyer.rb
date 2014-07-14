class Buyer < ActiveRecord::Base
  belongs_to :purchaser, polymorphic: true
end
