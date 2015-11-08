class VisitorsMeeting < ActiveRecord::Base
  validates :visitor_id, presence: true

  belongs_to :visitor
  belongs_to :meeting

  before_validation(on: :create) do
    binding.pry
  end

  # before_validation :call_me
  #
  # def call_me
  #   binding.pry
  # end
end
