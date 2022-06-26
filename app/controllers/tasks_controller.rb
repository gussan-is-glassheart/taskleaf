class TasksController < ApplicationController
  def index
    # すべてのタスクデータを取得し、@taskインスタンスメソッドへ代入
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  def create
    # task_paramsで取得したパラメータを変数taskに代入
    task = Task.new(task_params)
    task.save!
    # redirect_toにflashメッセージを渡している
    redirect_to tasks_url, notice: "タスク「#{task.name}」を登録しました"
  end

  private

  def task_params
    # フォームから送信されたデータが想定どおりのデータの形であることをチェック
    # 想定通りのデータのみを取得
    params.require(:task).permit(:name, :description)
  end
end
