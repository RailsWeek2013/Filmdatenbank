class AddProducderToFilms < ActiveRecord::Migration
  def change
    add_column :films, :producer, :string
  end
end
