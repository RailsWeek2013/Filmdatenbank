class AddUserToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :user, :integer
  end
end
