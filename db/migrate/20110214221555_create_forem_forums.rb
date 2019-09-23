class CreateForemForums < ActiveRecord::Migration[4.2]
  def up
    create_table :forem_forums do |t|
      t.string :title
      t.text :description
    end

  end

  def down
    drop_table :forem_forums
  end
end
