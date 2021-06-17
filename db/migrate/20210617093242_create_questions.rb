class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :answers, array: true
      t.boolean :multiple_correct
      t.string :correct_answers, array: true
      t.string :tags, array: true
      t.string :category
      t.string :difficulty

      t.timestamps
    end
  end
end
