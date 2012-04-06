# -*- encoding : utf-8 -*-
# Controller that set initial contexts and provides APIs for Users (and teachers, a particular occurrence of these)
class UsersController < ApplicationController

  protect_from_forgery
  respond_to :json
  skip_before_filter :require_login, :only => [:api_get_teacher_rating]

  # API that allows the user currently logged to rate a teacher
  #
  # @param [Integer] teacher_id Teacher to be rated
  # @param [Integer] rating Rating, 1 to 5
  # @param [String] comment Comments for the rating
  # @return [String] A rating object serialized as JSON
  # @raise [Error] any validation error that happens to occur
  def api_rate_a_teacher
    teacher_id = params[:teacher_id]
    rating = params[:rating]
    comment = params[:comment]

    raise "must specify teacher_id parameter" unless !teacher_id.nil?
    raise "must specify rating parameter" unless !rating.nil?
    raise "must specify comment parameter" unless !comment.nil?

    rating = current_user.rate_a_teacher(teacher_id, rating, comment)

    respond_with(rating)
  end

  # API for getting the rating of a teacher
  #
  # @param [Integer] teacher_id Teacher to be rated
  # @return [String] A simple JSON containing a string analogous to { rating = 3 }
  def api_get_teacher_rating
    teacher_id = params[:teacher_id]

    raise "must specify teacher_id parameter" unless !teacher_id.nil?
    raise "teacher_id must be a number" unless teacher_id.is_number?

    teacher = Teacher.find(teacher_id)

    respond_with(:rating => teacher.get_rating)
  end
end