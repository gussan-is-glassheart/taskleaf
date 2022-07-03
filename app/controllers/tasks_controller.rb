class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # すべてのタスクデータを取得し、@taskインスタンスメソッドへ代入
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  def create
    # task_paramsで取得したパラメータを変数taskに代入
    @task = current_user.tasks.new(task_params)

    if @task.save
    # redirect_toにflashメッセージを渡している
    redirect_to @task, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new
    end
  end

  private

  def task_params
    # フォームから送信されたデータが想定どおりのデータの形であることをチェック
    # 想定通りのデータのみを取得
    params.require(:task).permit(:name, :description)
  end

  def set_task
    # idパラメータからタスクオブジェクトを検索して@taskに代入する
    @task = current_user.tasks.find(params[:id])
  end
end
