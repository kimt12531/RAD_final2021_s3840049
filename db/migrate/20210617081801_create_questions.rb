class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.jsonb :answers
      t.boolean :multiple_correct
      t.jsonb :correct_answers
      t.jsonb :tags
      t.string :category
      t.string :difficulty

      t.timestamps
    end
  end
end
