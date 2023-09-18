class TasksController < ApplicationController
    before_action :authorize_manager, only: [:new, :create, :edit, :update, :move_to_done]
    before_action :authorize_employee, only: [:move_to_next_status]

  
    def index
      @to_do_tasks = Task.where(status: 'To Do')
      @in_progress_tasks = Task.where(status: 'In Progress')
      @review_tasks = Task.where(status: 'Review')
      @done_tasks = Task.where(status: 'Done')
      
    end
  
    def new
      @task = Task.new
    end
  
    def create
      @task = Task.new(task_params)
      # id = params[:employee_id]
      # puts "this is email #{id}"
      # @employee = Employee.find_by(email: id)
      # puts "this is employee #{@employee}"
      # @task.employee_id= @employee.id

      if @task.save
        flash[:success] = 'Task created successfully.'
        redirect_to index_path 
      else
        render :new
      end
    end
  
    def edit
      @task = Task.find(params[:id])
    end

    def move_to_next_status
      @task = Task.find(params[:id])
      
      @task.employees.each do |employee|
        if @current_employee.id == employee.id
          @temp = 1
        end 
      end

      if @temp.present?
      case @task.status
      when 'To Do'
        @task.status = 'In Progress'
      when 'In Progress'
        @task.status = 'Review'
      else
        flash[:error] = 'you are not allowed'
      end
    
      if @task.save
        flash[:success] = 'Task moved to the next status.'
      redirect_to index_path

      else
        flash[:error] = 'Failed to move the task.'
      redirect_to index_path
      end  
   end
    end
    
    def move_to_done
      @task = Task.find(params[:id])
      case @task.status
      when 'Review'
        @task.status = 'Done'
      else  
        flash[:error] = 'you are not allowed'
        redirect_to index_path
      end
      if @task.save
        flash[:success] = 'Task moved to the next status.'
      redirect_to index_path

      else
        flash[:error] = 'Failed to move the task.'
      redirect_to index_path
    end   
    end
  
    def update
      @task = Task.find(params[:id])
  
      # Handle adding employees
      if params[:task][:employee_ids_to_add].present?
        @task.employees << Employee.where(id: params[:task][:employee_ids_to_add])
      end
    
      # Handle removing employees
      if params[:task][:employee_ids_to_remove].present?
        @task.employees.delete(Employee.where(id: params[:task][:employee_ids_to_remove]))
      end
    
      if @task.update(task_params)
        flash[:success] = 'Task updated successfully.'
        redirect_to index_path
      else
        render :edit
      end
    
    end
  
    def destroy
      
      @task.destroy
      redirect_to tasks_path, notice: 'Task deleted successfully.'
    end
    
  
    private

    
    def authorize_manager
      token = session[:token]
      puts "token #{token}"
      if !token.present?
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

  def authorize_employee
    token = session[:token]
      if token==nil
        flash[:warning] = "please login first"
        redirect_to employee_login_path
      else
      verify = ::JsonWebToken.decode(token)
      id = verify['employee_id']
      @current_employee = Employee.find_by(id: id)
      if @current_employee.nil?
        flash[:warning] = "You are unauthorize user"
        redirect_to index_path
      end
      end
  end 

    def task_params
      params.require(:task).permit(:title, :description, :status, employee_ids: [])
    end
  end
  