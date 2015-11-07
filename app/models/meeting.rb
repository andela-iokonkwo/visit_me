class Meeting < ActiveRecord::Base
  validates :end_time, :start_time, :date, :venue, presence: true

  belongs_to :visitor
  belongs_to :user

  def visitor_email
    [ visitor.email ]
  end

end
