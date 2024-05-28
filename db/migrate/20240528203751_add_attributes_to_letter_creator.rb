class AddAttributesToLetterCreator < ActiveRecord::Migration[7.1]
  def change
    add_column :letter_creators, :recipient_name, :string
    add_column :letter_creators, :event_name, :string
    add_column :letter_creators, :date_and_time, :datetime
    add_column :letter_creators, :location, :string
    add_column :letter_creators, :recipient_likes, :string
  end
end
