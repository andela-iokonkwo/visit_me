require 'rails_helper'

RSpec.describe "meetings/new", type: :view do
  before(:each) do
    assign(:meeting, Meeting.new(
      :visitor => nil,
      :description => "MyText",
      :venue => "MyString",
      :user => nil
    ))
  end

  it "renders new meeting form" do
    render

    assert_select "form[action=?][method=?]", meetings_path, "post" do

      assert_select "input#meeting_visitor_id[name=?]", "meeting[visitor_id]"

      assert_select "textarea#meeting_description[name=?]", "meeting[description]"

      assert_select "input#meeting_venue[name=?]", "meeting[venue]"

      assert_select "input#meeting_user_id[name=?]", "meeting[user_id]"
    end
  end
end
