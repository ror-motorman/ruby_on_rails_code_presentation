class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :full_name, null: false
      t.integer :age, null: false
      t.datetime :interview_date, null: false
      t.timestamps
    end
  end
end
