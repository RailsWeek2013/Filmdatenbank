class CreateReviews < ActiveRecord::Migration
  def change
  	drop_table :film_reviews
  	drop_table :reviews
    create_table :reviews do |t|
      t.integer :note
      t.belongs_to :film
      t.belongs_to :user
      t.timestamps
    end
  end
end
