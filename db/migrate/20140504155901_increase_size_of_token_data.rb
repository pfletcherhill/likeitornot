class IncreaseSizeOfTokenData < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :oauth_token
      t.text :oauth_token
    end
  end
end
