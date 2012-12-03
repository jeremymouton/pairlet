require 'spec_helper'

describe "flirts/index" do
  before(:each) do
    assign(:flirts, [
      stub_model(Flirt,
        :handle => "Handle",
        :user => nil
      ),
      stub_model(Flirt,
        :handle => "Handle",
        :user => nil
      )
    ])
  end

  it "renders a list of flirts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Handle".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
