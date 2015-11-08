class Visitor < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}, unless: Proc.new { |data| new_entry_for_user(data.email) }
  validates :name, presence: true

  has_many :visitors_meeting
  has_many :meetings, through: :visitors_meeting
  belongs_to :user

  def new_entry_for_user(data)
    Visitor.find_by(email: data, user_id: self.user_id)
  end
end
