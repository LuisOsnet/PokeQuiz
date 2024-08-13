class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :finished, default: false
      t.integer :score, default: 0

      t.timestamps
    end
  end
end
