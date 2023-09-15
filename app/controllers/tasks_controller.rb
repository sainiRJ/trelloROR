class TasksController < ApplicationController
    before_action :authorize_manager, only: [:new, :create, :edit, :update]
  
    def index
      @tasks = Task.all
    end
  
    def new
      @task = Task.new
    end
  
    def create
      @task = Task.new(task_params)
      id = @task.employee
      @employee = Employee.find_by(email: id)
      @task.employee_id= @employee.id

      if @task.save
        redirect_to tasks_path, notice: 'Task created successfully.'
      else
        render :new
      end
    end
  
    def edit
      
    end
  
    def update
     
      if @task.update(task_params)
        redirect_to tasks_path, notice: 'Task updated successfully.'
      else
        render :edit
      end
    end
  
    def destroy
      
      @task.destroy
      redirect_to tasks_path, notice: 'Task deleted successfully.'
    end
  
    def assign

    end
  
    def mark_for_review
    
    end
  
    def review
     
    end
  
    def complete_review
     
    end
  
    private
    
    def authorize_manager
      token = session[:token]
      if token==nil
        flash[:warning] = "please login first"
        redirect_to manager_login_path
      else
      verify = ::JsonWebToken.decode(token)
      id = verify['manager_id']
      @current_manager = Manager.find_by(id: id)
      if @current_manager.nil?
        flash[:warning] = "You are unauthorize user"
        redirect_to manager_index_path
      end
      end
    end

    def task_params
      params.require(:task).permit(:title, :description, :employee, :status)
    end
  end
  