class MeetingsController < ApplicationController
  include VisitorManager
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  def index
    @meetings = Meeting.all
  end

  def show
  end

  def new
    @meeting = Meeting.new
    @meeting.visitors_meeting.build
  end

  def edit
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user
      if @meeting.save && save_visitor_meeting(visitor_params, @meeting.id)
        # session[:meeting_id] = @meeting.id
        # if session[:token]
        #   create_google_event
        # else
        #   redirect_to "/auth/google_oauth2"
        # end
      else
        respond_to do |format|
          format.html { render :new }
          format.json { render json: @meeting.errors, status: :unprocessable_entity }
        end
      end
  end


  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_google_event
    @meeting = Meeting.find(session[:meeting_id])
    client = Google::APIClient.new
    client.authorization.access_token = session['token']
    service = client.discovered_api('calendar', 'v3')
    @set_event = set_event(service, client)
    respond_to do |format|
      format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
      format.json { render :show, status: :created, location: @meeting }
    end
  end

  private

    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def meeting_params
      params.require(:meeting).permit(:start_time, :end_time, :date, :description, :venue, :title)
    end

    def visitor_params
      params.require(:visitors_meeting).permit(visitors_id: [])
    end

     def event
    {
      'summary' => @meeting.title,
      'description' => @meeting.description,
      'location' => @meeting.venue,
      'start' => { 'dateTime' => parse_time(@meeting.start_time, @meeting.date)},
      'end' => { 'dateTime' => parse_time(@meeting.end_time, @meeting.date)},
      'attendees' => @meeting.visitor_email.map do | email |
          { email: email }
      end
    }
  end

  def set_event(service, client)
    client.execute(:api_method => service.events.insert,
                            :parameters => {'calendarId' => session['email'], 'sendNotifications' => true},
                            :body => JSON.dump(event),
                            :headers => {'Content-Type' => 'application/json'})
  end

  def parse_time(meeting_time, meeting_date)
    time = convert_time_to_i(meeting_time)
    (meeting_date.to_time + time).to_datetime.rfc3339
  end

  def convert_time_to_i(meeting_time)
    (meeting_time.hour * 3600) + (meeting_time.min * 60)
  end
end
