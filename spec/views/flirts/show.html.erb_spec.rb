require 'spec_helper'

describe "flirts/show" do
  before(:each) do
    @flirt = assign(:flirt, stub_model(Flirt,
      :handle => "Handle",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Handle/)
    rendered.should match(//)
  end
end
