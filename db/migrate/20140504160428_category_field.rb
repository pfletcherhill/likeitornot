class CategoryField < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.remove :category
      t.remove :picture
      t.text :category
      t.text :picture
    end
  end
end
