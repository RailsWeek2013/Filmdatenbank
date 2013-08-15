class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :title
      t.string :picture
      t.string :description
      t.string :link

      t.timestamps
    end
  end
end
