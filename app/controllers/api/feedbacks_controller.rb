module Api
  class FeedbacksController < ApplicationController
    def create
      Feedback.create!(feedback_params)
    end

    def feedback_params
      params.require(:feedback).permit(:name, :comment)
    end
  end
end
