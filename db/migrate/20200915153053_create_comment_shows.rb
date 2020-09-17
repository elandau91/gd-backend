class CreateCommentShows < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_shows do |t|
      t.integer :user_id
      t.belongs_to :show, type: :string
      t.string :content
    end
  end
end
