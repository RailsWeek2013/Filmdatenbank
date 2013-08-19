class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.string :subject
      t.string :text
      t.boolean :read, default: false
      t.boolean :deleted_by_sender, default: false
      t.boolean :deleted_by_recipient, default: false

      t.timestamps
    end
  end
end
