class ApproveAllTopicsAndPosts < ActiveRecord::Migration[4.2]
  def up
    Forem::Topic.update_all :state => "approved"
    Forem::Post.update_all :state => "approved"
  end

  def down
  end
end

