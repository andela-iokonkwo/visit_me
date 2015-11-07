module ApplicationHelper
  def display_notification(meeting)
    if meeting.errors.any?
      content = ''
      content = content_tag(:h2, "#{ pluralize(meeting.errors.count, "error") }prohibited this meeting from being saved:")
      meeting.errors.full_messages.each { |message| content << content_tag(:li, message) }
      content = content_tag(:ul, content)
      content = content_tag(:div, content, id: "error_explanation")
    end
  end
end
