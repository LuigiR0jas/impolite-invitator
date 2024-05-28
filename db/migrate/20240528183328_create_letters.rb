class CreateLetters < ActiveRecord::Migration[7.1]
  def change
    create_table :letters do |t|
      t.string :title
      t.string :body
      t.references :letter_creator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
