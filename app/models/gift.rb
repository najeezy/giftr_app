class Gift < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :buyer

  validates :name, :category, :price, :small_image_url, :large_image_url,
            :amazon_url, :user_id, :event_id,
            presence: true

  # validates :buyer_id, :user_id, :event_id, numericality: {greater_than: 0}
  validates :price, numericality: {greater_than: -1}
  validates :status, inclusion: {in: %w(unclaimed bought claimed cancelled)}

  def claimed?
    self.status == 'claimed'
  end

  def cancelled?
    self.status == 'cancelled'
  end
end
