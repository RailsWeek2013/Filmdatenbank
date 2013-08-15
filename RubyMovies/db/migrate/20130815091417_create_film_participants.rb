class CreateFilmParticipants < ActiveRecord::Migration
  def change
    create_table :film_participants do |t|
      t.integer :film_id
      t.integer :participant_id

      t.timestamps
    end
  end
end
