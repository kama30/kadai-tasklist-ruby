class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  
  def index
    @tasks = current_user.tasks.order(id: :desc)
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: "タスクを登録しました！"
    else
      flash[:notice] = "タスクの登録に失敗しました！"
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      redirect_to @task, notice: "タスクを編集しました！"
    else
      flash[:notice] = "タスクの編集に失敗しました！"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:notice] = "タスクを削除しました！"
    redirect_to root_path
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
