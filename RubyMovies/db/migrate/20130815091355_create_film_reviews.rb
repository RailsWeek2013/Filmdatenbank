class CreateFilmReviews < ActiveRecord::Migration
  def change
    create_table :film_reviews do |t|
      t.integer :film_id
      t.integer :review_id

      t.timestamps
    end
  end
end
