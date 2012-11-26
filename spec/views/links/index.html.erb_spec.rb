require 'spec_helper'

describe "links/index" do
  before(:each) do
    assign(:links, [
      stub_model(Link,
        :provider => "Provider",
        :handle => "Handle",
        :user => nil
      ),
      stub_model(Link,
        :provider => "Provider",
        :handle => "Handle",
        :user => nil
      )
    ])
  end

  it "renders a list of links" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Provider".to_s, :count => 2
    assert_select "tr>td", :text => "Handle".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
