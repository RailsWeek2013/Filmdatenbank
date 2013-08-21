class AddDirectorToFilms < ActiveRecord::Migration
  def change
    add_column :films, :director, :string
  end
end
