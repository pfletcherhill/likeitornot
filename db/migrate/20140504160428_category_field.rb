class CategoryField < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.remove :category
      t.text :category
    end
  end
end
