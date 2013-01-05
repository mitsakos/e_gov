class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :question
      t.integer :votes_count, :default => 0

      t.timestamps
    end
  end
end
