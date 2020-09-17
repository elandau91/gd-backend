class CreateFaveShows < ActiveRecord::Migration[5.2]
  def change
    create_table :fave_shows do |t|
      t.integer :user_id
      t.belongs_to :show, type: :string
    end
  end
end
