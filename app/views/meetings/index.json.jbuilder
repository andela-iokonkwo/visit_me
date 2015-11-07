json.array!(@meetings) do |meeting|
  json.extract! meeting, :id, :visitor_id, :start_time, :end_time, :date, :description, :venue, :user_id
  json.url meeting_url(meeting, format: :json)
end
