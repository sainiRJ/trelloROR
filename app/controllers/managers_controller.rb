require_relative "../../lib/json_web_token"
require 'securerandom'

class ManagersController < ApplicationController
    def new
        @manager = Manager.new
    end

    def create
        @manager= Manager.new(manager_params)
        @email = @manager.email
        session[:user] = @manager
        mailOTP = SecureRandom.random_number(1_000_000).to_s.rjust(6, '0')
        puts mailOTP
        session[:mailOTP] = mailOTP
       if ::OtpMailer.send_otp(@email, mailOTP).deliver_now
        redirect_to manager_verify_path
       end
    end
def postVerify
    def verify
    end
        if session[:mailOTP] == params[:mailOTP]
            puts "hello pst #{session[:user]}"
            user = Manager.new(session[:user])
            if user.save
                puts "user save success"
                session.delete(:mailOTP)
                session.delete(:user)
                flash[:success] = "Yor are create registration successfully"
                redirect_to manager_login_path

            else
                flash[:danger] = user.errors.full_messages
                redirect_to new_path
            end
        else
            flash[:warning] = "Invalid OTP. Please try again."
            redirect_to manager_verify_path
        end
end
    def login
        def login_form
        end
        email = params[:email]
        password = params[:password]
        puts "Params: #{params.inspect}"
        @manager = Manager.find_by(email: email)
        if @manager && @manager.authenticate(password)
            payload={ manager_id: @manager.id}
            token = ::JsonWebToken.encode(payload)
            puts token
            session[:token] = token
            flash[:success] = "you are login successfully"
            redirect_to manager_index_path
        end
    end

    def index

    end
    
    def manager
        manager = Manager.all
        render json: manager
    end

    def manager_params 
        params.require(:manager).permit(:name, :mobile_number, :email, :password, :password_confirmation)
    end 
end
