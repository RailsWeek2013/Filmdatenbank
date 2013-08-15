class AddFilmIdToFilmTags < ActiveRecord::Migration
  def change
    add_column :film_tags, :film_id, :integer
  end
end
