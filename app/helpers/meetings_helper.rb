module MeetingsHelper
  def show_user_visitors
    content = label_tag :visitor_id, "Visitors"
     content << select(:visitors_meeting, :visitors_id, options_for_select(current_user.visitors.pluck("name, id")), {}, { class: "multi-select", multiple: true})
     content
  end

  def meetings_ajax_previous_link
    ->(param, date_range) { link_to raw("&laquo;"), {param => date_range.first - 1.day}, remote: :true}
  end

  def meetings_ajax_next_link
    ->(param, date_range) { link_to raw("&raquo;"), {param => date_range.last + 1.day}, remote: :true}
  end

end
