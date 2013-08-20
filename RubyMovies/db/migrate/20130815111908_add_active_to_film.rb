class AddActiveToFilm < ActiveRecord::Migration
  def change
    add_column :films, :active, :boolean, default: false
  end
end
