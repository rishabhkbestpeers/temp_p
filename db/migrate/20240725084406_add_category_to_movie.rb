class AddCategoryToMovie < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :category, :string
  end
end
