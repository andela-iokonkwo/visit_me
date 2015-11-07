module MeetingsHelper
  def show_user_visitor
    current_user.visitors
  end
end
