require 'spec_helper'

describe "links/new" do
  before(:each) do
    assign(:link, stub_model(Link,
      :provider => "MyString",
      :handle => "MyString",
      :user => nil
    ).as_new_record)
  end

  it "renders new link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => links_path, :method => "post" do
      assert_select "input#link_provider", :name => "link[provider]"
      assert_select "input#link_handle", :name => "link[handle]"
      assert_select "input#link_user", :name => "link[user]"
    end
  end
end
