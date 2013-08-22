class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :q1_id
      t.integer :q2_id
      t.integer :q3_id
      t.integer :q4_id
      t.integer :q5_id

      t.timestamps
    end
  end
end
