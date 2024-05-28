class LetterCreatorsController < ApplicationController
  before_action :create_letter_creator, only: [:new]

  def new
    redirect_to edit_letter_creator_path(@letter_creator.id)
  end

  private

  def create_letter_creator
    @letter_creator = LetterCreator.create!
  end
end
