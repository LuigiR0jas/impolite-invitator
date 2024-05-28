class CreateLetterCreators < ActiveRecord::Migration[7.1]
  def change
    create_table :letter_creators do |t|
      t.string :name

      t.timestamps
    end
  end
end
