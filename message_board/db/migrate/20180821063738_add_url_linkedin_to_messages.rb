class AddUrlLinkedinToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :url_linkedin, :string
  end
end
