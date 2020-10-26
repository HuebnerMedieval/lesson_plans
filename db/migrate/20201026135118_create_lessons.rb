class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :learning_obj
      t.string :length
      t.string :summary
      t.string :assessment
      t.integer :teacher_id
    end
  end
end
