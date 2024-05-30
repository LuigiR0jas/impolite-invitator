class Letter < ApplicationRecord
  belongs_to :letter_creator

  def broadcast_body(target, content)
    broadcast_update_to(
      letter_creator,
      target:,
      content:
    )
  end
end
