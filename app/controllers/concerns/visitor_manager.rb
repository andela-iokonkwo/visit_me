module VisitorManager
  def save_visitor_meeting(data, meeting_id)
    ids = data[:visitors_id]
    ids.delete("")
    return unless ids.size > 1

    save_ids = []
    ids.each do |id|
      save_ids << VisitorsMeeting.new(meeting_id: meeting_id, visitor_id: id)
    end
    VisitorsMeeting.import save_ids
  end
end
