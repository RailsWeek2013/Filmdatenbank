class CreateBlocklists < ActiveRecord::Migration
  def change
    create_table :blocklists do |t|
      t.integer :user_id
      t.integer :blocked_id

      t.timestamps
    end
  end
end
