require 'spec_helper'

describe "faqs/index.html.haml" do
  before(:each) do
    assign(:faqs, [
      stub_model(Faq,
        :id => 1,
        :question => "MyText",
        :answer => "MyText",
        :permalink => "MyText",
        :tags => "MyText"
      ),
      stub_model(Faq,
        :id => 1,
        :question => "MyText",
        :answer => "MyText",
        :permalink => "MyText",
        :tags => "MyText"
      )
    ])
  end

  it "renders a list of faqs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
