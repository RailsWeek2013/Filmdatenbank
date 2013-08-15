class AddTagIdToFilmTags < ActiveRecord::Migration
  def change
    add_column :film_tags, :tag_id, :integer
  end
end
