class AddAverageGradeToFilms < ActiveRecord::Migration
  def change
    add_column :films, :average, :float
  end
end
