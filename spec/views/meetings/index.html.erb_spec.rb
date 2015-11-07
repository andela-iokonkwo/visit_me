require 'rails_helper'

RSpec.describe "meetings/index", type: :view do
  before(:each) do
    assign(:meetings, [
      Meeting.create!(
        :visitor => nil,
        :description => "MyText",
        :venue => "Venue",
        :user => nil
      ),
      Meeting.create!(
        :visitor => nil,
        :description => "MyText",
        :venue => "Venue",
        :user => nil
      )
    ])
  end

  it "renders a list of meetings" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Venue".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
