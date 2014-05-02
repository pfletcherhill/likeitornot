class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :url
      t.string :category
      t.string :picture
      t.string :uid
      t.timestamps
    end
    
    create_join_table :pages, :users do |t|
      t.index :user_id
      t.index :page_id
    end
  end
end
