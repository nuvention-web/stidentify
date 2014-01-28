class InstructorsController < ApplicationController

  def new
    @instructor = Instructor.new
  end

  def create
  end

  def show
    @instructor = Instructor.find(params[:id])
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

end