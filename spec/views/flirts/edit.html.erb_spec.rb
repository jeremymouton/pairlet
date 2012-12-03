require 'spec_helper'

describe "flirts/edit" do
  before(:each) do
    @flirt = assign(:flirt, stub_model(Flirt,
      :handle => "MyString",
      :user => nil
    ))
  end

  it "renders the edit flirt form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => flirts_path(@flirt), :method => "post" do
      assert_select "input#flirt_handle", :name => "flirt[handle]"
      assert_select "input#flirt_user", :name => "flirt[user]"
    end
  end
end
