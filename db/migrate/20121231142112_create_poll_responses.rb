class CreatePollResponses < ActiveRecord::Migration
  def change
    create_table :poll_responses do |t|
      t.references :poll
      t.references :user
      t.references :poll_option

      t.timestamps
    end
    add_index :poll_responses, :poll_id
    add_index :poll_responses, :user_id
    add_index :poll_responses, :poll_option_id
  end
end
