class LetterCreatorsController < ApplicationController
  before_action :create_letter_creator, only: [:new]

  def new
    redirect_to edit_letter_creator_path(@letter_creator.id)
  end

  def edit
    @letter_creator = LetterCreator.find(params[:id])
    @letter = @letter_creator.letters.last
  end

  def update
    message_creator = MessageCreator.new(params: letter_params)
    response = message_creator.call

    @letter_creator = LetterCreator.find(params[:id])
    @letter = Letter.new(letter_creator: @letter_creator, body: response)

    ActiveRecord::Base.transaction do
      @letter_creator.update!(letter_params)
      @letter.save!
    end

    redirect_to edit_letter_creator_path(@letter_creator.id)
  end

  private

  def create_letter_creator
    @letter_creator = LetterCreator.create!
  end

  def letter_params
    params.require(:letter_creator).permit(:recipient_name, :event_name, :date_and_time, :location, :recipient_likes)
  end
end
