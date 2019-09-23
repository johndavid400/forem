class AddForem < ActiveRecord::Migration[4.2]

  def up

    if ActiveRecord::Base.connection.data_source_exists? 'forem_forums'
      add_column :forem_forums, :position, :integer, default: 0
    else
      create_table :forem_forums do |t|
        t.string :name
        t.text :description
        t.integer :category_id
        t.string :slug
        t.integer :views_count, default: 0
        t.integer :position, default: 0
      end
    end

    create_table :forem_topics do |t|
      t.integer :forum_id
      t.integer :user_id
      t.string :subject
      t.boolean :locked, null: false, default: false
      t.boolean :pinned, default: false, nullable: false
      t.boolean :hidden, default: false
      t.datetime :last_post_at
      t.string :state, default: 'pending_review'
      t.integer :views_count, default: 0
      t.string :slug

      t.timestamps :null => true
    end

    create_table :forem_posts do |t|
      t.integer :topic_id
      t.text :text
      t.integer :user_id
      t.integer :reply_to_id
      t.string :state, default: 'pending_review'
      t.boolean :notified, default: false

      t.timestamps :null => true
    end

    create_table :forem_views do |t|
      t.integer :user_id
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :count, default: 0
      t.integer :viewable_id
      t.string :viewable_type
      t.datetime :current_viewed_at
      t.datetime :past_viewed_at
    end

    if ActiveRecord::Base.connection.data_source_exists? 'forem_forums'
      add_column :forem_categories, :position, :integer, default: 0
    else
      create_table :forem_categories do |t|
        t.string :name, :null => false
        t.string :slug
        t.integer :position, :default => 0

        t.timestamps :null => true
      end
    end

    create_table :forem_subscriptions do |t|
      t.integer :subscriber_id
      t.integer :topic_id
    end

    create_table :forem_groups do |t|
      t.string :name
    end

    create_table :forem_memberships do |t|
      t.integer :group_id
      t.integer :member_id
    end

    create_table :forem_moderator_groups do |t|
      t.integer :forum_id
      t.integer :group_id
    end


    unless column_exists?(user_class, :forem_admin)
      add_column user_class, :forem_admin, :boolean, :default => false
    end

    unless column_exists?(user_class, :forem_state)
      add_column user_class, :forem_state, :string, :default => 'pending_review'
    end

    unless column_exists?(user_class, :forem_auto_subscribe)
      add_column user_class, :forem_auto_subscribe, :boolean, :default => false
    end

    add_index :forem_forums, :slug, :unique => true

    add_index :forem_topics, :forum_id
    add_index :forem_topics, :user_id
    add_index :forem_topics, :state
    add_index :forem_topics, :slug, :unique => true

    add_index :forem_posts, :topic_id
    add_index :forem_posts, :user_id
    add_index :forem_posts, :reply_to_id
    add_index :forem_posts, :state

    add_index :forem_views, :user_id
    add_index :forem_views, :topic_id
    add_index :forem_views, :updated_at

    add_index :forem_categories, :slug, :unique => true
    add_index :forem_groups, :name
    add_index :forem_memberships, :group_id
    add_index :forem_moderator_groups, :forum_id

  end

  def user_class
    Forem.user_class.table_name.downcase.to_sym
  end

end
