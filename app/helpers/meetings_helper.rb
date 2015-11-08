module MeetingsHelper
  def show_user_visitors
    content = label_tag :visitor_id, "Visitors"
     content << select(:visitors_meeting, :visitors_id, options_for_select(current_user.visitors.pluck("name, id")), {}, { class: "multi-select", multiple: true})
     content
  end

end
