class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :uid
      t.integer :user_id
      t.boolean :done
      t.timestamps
    end
  end
end
