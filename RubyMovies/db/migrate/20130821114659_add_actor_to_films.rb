class AddActorToFilms < ActiveRecord::Migration
  def change
    add_column :films, :actor, :string
  end
end
