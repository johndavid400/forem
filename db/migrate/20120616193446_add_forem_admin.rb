class AddForemAdmin < ActiveRecord::Migration[4.2]
  def change
    unless column_exists?(user_class, :forem_admin)
      add_column user_class, :forem_admin, :boolean, :default => false
    end
  end

  def user_class
    Forem.user_class.table_name.downcase.to_sym
  end
end
