class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.references :forum
      t.references :user
      t.integer :last_poster_id
      t.datetime :last_post_at

      t.timestamps
    end
    add_index :topics, :forum_id
    add_index :topics, :user_id
  end
end
