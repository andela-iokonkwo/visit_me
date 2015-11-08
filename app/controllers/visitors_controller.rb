class VisitorsController < ApplicationController
  def create
    visitor = Visitor.new(visitor_params)
    visitor.user_id = current_user.id
    respond_to do |format|
      if visitor.save
        format.js {render :visitor_saved}
      else
        format.js {render :visitor_not_saved}
      end
    end
  end

  private

  def visitor_params
    params.require(:visitor).permit(:name, :email)
  end
end
