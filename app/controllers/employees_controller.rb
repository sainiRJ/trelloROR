class EmployeesController < ApplicationController
  def new
    @employee = Employee.new
  end

  def create
    @employee= Employee.new(employee_params)
    @email = @employee.email
    session[:user] = @employee
    mailOTP = SecureRandom.random_number(1_000_000).to_s.rjust(6, '0')
    puts mailOTP
    session[:mailOTP] = mailOTP
   if ::OtpMailer.send_otp(@email, mailOTP).deliver_now
    redirect_to employee_verify_path
   end
  end

  def postVerify
    def verify
    end
        if session[:mailOTP] == params[:mailOTP]
            puts "hello pst #{session[:user]}"
            user = Employee.new(session[:user])
            if user.save
                puts "user save success"
                session.delete(:mailOTP)
                session.delete(:user)
                flash[:success] = "Yor are create registration successfully"
                redirect_to employee_login_path

            else
                flash[:danger] = user.errors.full_messages
                redirect_to employee_register_path
            end
        else
            flash[:warning] = "Invalid OTP. Please try again."
            redirect_to employee_verify_path
        end
end
    def login
        def login_form
        end
        email = params[:email]
        password = params[:password]
        puts "Params: #{params.inspect}"
        @employee = Employee.find_by(email: email)
        if @employee && @employee.authenticate(password)
            payload={ employee_id: @employee.id}
            token = ::JsonWebToken.encode(payload)
            puts token
            session[:token] = token
            flash[:success] = "you are login successfully"
            redirect_to index_path
        end
    end

  def index
  end

  def employee_params
    params.require(:employee).permit(:name, :mobile_number, :email, :password, :password_confirmation)
  end
end
