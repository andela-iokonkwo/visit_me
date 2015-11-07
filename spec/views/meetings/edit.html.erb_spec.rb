require 'rails_helper'

RSpec.describe "meetings/edit", type: :view do
  before(:each) do
    @meeting = assign(:meeting, Meeting.create!(
      :visitor => nil,
      :description => "MyText",
      :venue => "MyString",
      :user => nil
    ))
  end

  it "renders the edit meeting form" do
    render

    assert_select "form[action=?][method=?]", meeting_path(@meeting), "post" do

      assert_select "input#meeting_visitor_id[name=?]", "meeting[visitor_id]"

      assert_select "textarea#meeting_description[name=?]", "meeting[description]"

      assert_select "input#meeting_venue[name=?]", "meeting[venue]"

      assert_select "input#meeting_user_id[name=?]", "meeting[user_id]"
    end
  end
end
