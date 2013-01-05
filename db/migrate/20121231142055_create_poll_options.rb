class CreatePollOptions < ActiveRecord::Migration
  def change
    create_table :poll_options do |t|
      t.string :option
      t.references :poll
      t.integer :poll_responses_count, :default => 0

      t.timestamps
    end
    add_index :poll_options, :poll_id
  end
end
