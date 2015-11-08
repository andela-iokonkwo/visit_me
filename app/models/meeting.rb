class Meeting < ActiveRecord::Base
  validates :end_time, :start_time, :date, :venue, :title, presence: true

  has_many :visitors_meeting
  has_many :visitors, through: :visitors_meeting
  belongs_to :user

  def visitor_email
    [ visitor.email ]
  end

end
