class LetterCreatorsController < ApplicationController
  before_action :set_letter_creator, only: %i[edit update]

  def new
    @letter_creator = LetterCreator.create!
    redirect_to edit_letter_creator_path(@letter_creator.id)
  end

  def edit
    @letter = @letter_creator.letters.last
  end

  def update
    @letter = Letter.new(letter_creator: @letter_creator)
    message_creator = MessageCreator.new(params: letter_params, model: @letter, target: @letter_creator)
    response = message_creator.call

    ActiveRecord::Base.transaction do
      @letter_creator.update!(letter_params)
      @letter.assign_attributes(body: response)
      @letter.save!
    end

    redirect_to edit_letter_creator_path(@letter_creator.id)
  end

  private

  def set_letter_creator
    @letter_creator = LetterCreator.find(params[:id])
  end

  def letter_params
    params.require(:letter_creator).permit(:recipient_name, :event_name, :date_and_time, :location, :recipient_likes)
  end
end
