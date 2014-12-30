class AddOauthIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :oauth_token
  end
end
