require_relative "../../lib/json_web_token"
require 'securerandom'

class AdminsController < ApplicationController
    def new
        @admin = Admin.new
    end

    def create
        @admin= Admin.new(admin_params)
        @email = @admin.email
        session[:user] = @admin
        mailOTP = SecureRandom.random_number(1_000_000).to_s.rjust(6, '0')
        session[:mailOTP] = mailOTP
       if ::OtpMailer.send_otp(@email, mailOTP).deliver_now
        redirect_to admin_verify_path
       end
    end
def postVerify
    def verify
    end
        if session[:mailOTP] == params[:mailOTP]
            puts "hello pst #{session[:user]}"
            user = admin.new(session[:user])
            if user.save
                puts "user save success"
                session.delete(:mailOTP)
                session.delete(:user)
                flash[:success] = "Yor are create registration successfully"
                redirect_to admin_login_path

            else
                flash[:danger] = user.errors.full_messages
                redirect_to new_path
            end
        else
            flash[:warning] = "Invalid OTP. Please try again."
            redirect_to admin_verify_path
        end
end
    def login
        def login_form
        end
        email = params[:email]
        password = params[:password]
        @admin = Admin.find_by(email: email)
        if @admin && @admin.authenticate(password)
            payload={ admin_id: @admin.id}
            token = ::JsonWebToken.encode(payload)
            session[:token] = token
            flash[:success] = "you are login successfully"
            redirect_to manager_index_path
        end
    end

    def index

    end

    def change_role
        @user = User.find(params[:id])
        new_role = params[:role] # You may use a dropdown or radio buttons to select the new role
      
        if @user.update(role: new_role)
          flash[:success] = 'User role updated successfully.'
        else
          flash[:error] = 'Failed to update user role.'
        end
      
        redirect_to users_path
    end
    
    def admin
        admin = admin.all
        render json: admin
    end

    def admin_params 
        params.require(:admin).permit(:name, :mobile_number, :email, :password, :password_confirmation)
    end 
end
