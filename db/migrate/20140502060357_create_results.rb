class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :game_id
      t.integer :page_id
      t.boolean :answer
      t.boolean :correct    
    end
  end
end
