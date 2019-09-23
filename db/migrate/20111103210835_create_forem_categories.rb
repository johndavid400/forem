class CreateForemCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :forem_categories do |t|
      t.string :name, :null => false
      t.timestamps
    end
  end
end
