class Event < ActiveRecord::Base
  has_many :gifts, dependent: :destroy
  belongs_to :user

  validates :title, :date, :user_id, presence: true
  validates :user_id, numericality: { greater_than: 0 }
  validates :date, length: { maximum: 10 }

  def fdate
    self.date.strftime("%A, %B #{self.date.day.ordinalize}, %Y")
  end

  def self.check_date(date)
    if /(0[1-9]|1[012])[- \/.](0[1-9]|[12][0-9]|3[01])[- \/.]\d\d\d\d/ =~ date
      date = date.split('/')
      date = date[2]+"-"+date[0]+"-"+date[1]
      date = Date.parse(date)
      date = nil if date <= Date.today
    else
      date = nil
    end
    date ? date.to_s : nil
  end

end
