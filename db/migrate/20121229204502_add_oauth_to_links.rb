class AddOauthToLinks < ActiveRecord::Migration
  def change
    add_column :links, :uid, :string
    add_column :links, :oauth_token, :string
    add_column :links, :oauth_expires_at, :datetime
  end
end
