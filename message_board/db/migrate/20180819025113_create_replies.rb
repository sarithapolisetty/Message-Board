class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.string :title
      t.text :content
      t.references :message, foreign_key: true

      t.timestamps
    end
  end
end
