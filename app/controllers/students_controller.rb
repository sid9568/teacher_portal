class StudentsController < ApplicationController
  # before_action :set_students, only: [:index]

  def index
    if params[:search].present?
      @students = Student.where('name ILIKE ?', "%#{params[:search]}%")
    else
      @students = Student.all
    end
  end

  def create
    student = Student.find_by(name: student_params[:name], subject: student_params[:subject])

    if student
      p "======="
      flash[:alert] = 'already exists in the database.'
      redirect_to students_path
    else
      @student = Student.new(student_params)
      if @student.save
        flash[:success] = 'Student created successfully'
        redirect_to students_path
      else
        flash[:alert] = 'already exists in the database.'
        redirect_to students_path
      end
    end
  end


  def update
    student = Student.find(params[:id])
    if student.update(student_params)
      redirect_to students_path, notice: 'Student updated successfully'
    else
      @students = Student.all # Ensure you have @students available if rendering the index view
      render :index
    end
  end

  def destroy
    Student.find(params[:id]).destroy
    redirect_to students_path
  end

  private

  def set_students
    @students = current_user.students
  end

  def student_params
    params.permit(:name, :subject, :marks)
  end
end
