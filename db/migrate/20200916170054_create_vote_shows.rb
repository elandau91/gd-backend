class CreateVoteShows < ActiveRecord::Migration[5.2]
  def change
    create_table :vote_shows do |t|
      t.integer :user_id
      t.belongs_to :show, type: :uuid
      t.integer :vote
    end
  end
end
