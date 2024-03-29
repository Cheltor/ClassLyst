class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :admin_user, except: [:index, :show, :enroll]
  
  # GET /courses
  # GET /courses.json
  def index
    @search = Course.ransack(params[:q])
    @courses = @search.result(distinct: true).paginate(page: params[:page], per_page: 24)
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @search = Post.ransack(params[:q])
    @posts = @search.result(distinct: true).includes(:comments).where(course_id: @course.id).where(flagged: false).order("created_at DESC").paginate(page: params[:page], per_page: 15)

     if user_signed_in?
      @enrolls = Enroll.all.where(user_id: current_user.id).where(course_id: @course.id)
      @signup = Enroll.all.where(course_id: @course.id)
    else
      @enrolls = Enroll.all.where(course_id: @course.id)
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /enrolls
  # POST /enrolls.json
  def enroll
    @course = Course.find(params[:id])
    @enroll = @course.enrolls.create(params.permit(:course_id,:user_id))
    @enroll.user_id = current_user.id

       respond_to do |format|
        if @enroll.save
          format.html { redirect_to @course, notice: 'Enroll was successfully created.' }
          format.json { render json: @enroll, status: :created, location: @enroll }
        else
          format.html { redirect_to @course}
          format.json { render json: @enroll.errors, status: :unprocessable_entity }
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Security
    def admin_user
      redirect_to root_path unless current_user.admin? 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:university_id, :name)
    end
end
