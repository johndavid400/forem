class RenameTitleToNameOnForemForums < ActiveRecord::Migration[4.2]
  def up
    rename_column :forem_forums, :title, :name
  end

  def down
    rename_column :forem_forums, :name, :title
  end
end
