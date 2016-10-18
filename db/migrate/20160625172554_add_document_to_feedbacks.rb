class AddDocumentToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :document, :string
  end
end
