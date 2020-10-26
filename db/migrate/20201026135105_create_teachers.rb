class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :password_digest
      t.integer :subject_id
    end
  end
end
