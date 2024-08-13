class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.references :game, null: false, foreign_key: true
      t.string :question, null: false
      t.string :user_answer, null: false
      t.string :correct_answer, null: false
      t.integer :points, default: 0, null: false

      t.timestamps
    end
  end
end
