class AddUrlGoogleToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :url_google, :string
  end
end
