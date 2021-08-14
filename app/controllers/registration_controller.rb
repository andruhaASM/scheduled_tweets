class RegistrationController < ApplicationController
	def new
		@user = User.new
	end

	def create
		if User.find_by(params[:email]) == nil
			@user = User.new(user_params)
			if @user.save
				session[:user_id] = @user.id
				redirect_to root_path, notice: "Conta criada com sucesso!"
			else
				flash[:alert] = "Algo ocorreu errado..."
				render :new
			end
		else
			redirect_to sign_up_path, alert: "Usuário já existe. Por favor escolhe outro email"
		end

	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end