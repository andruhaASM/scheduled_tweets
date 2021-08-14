class PasswordsResetsController < ApplicationController
	def new
	end

	
	def create
		@user = User.find_by(email:params[:email])
		if @user.present?
			PasswordMailer.with(user: @user).reset.deliver_later
		end
		redirect_to root_path, notice: "Se a conta com esse email for localizada, a gente te envia um email com link com recuperação da senha"
	end

	
	def edit
		@user = User.find_signed!(params[:token], purpose: "password_reset")
	rescue ActiveSupport::MessageVerifier::InvalidSignature
		redirect_to sign_in_path, alert: "O seu token de redefinição de senha expirou. Tente novamente, por favor."
	end

	
	def update
		@user = User.find_signed!(params[:token], purpose: "password_reset")
		if @user.update(password_params)
			redirect_to sign_in_path, notice: "A sua senha foi redefinida com sucesso, por favor faça o login novamente."
		else
			render :edit
		end
	end

	

	private

	def password_params
		params.require(:user).permit(:password, :password_confirmation)
	end

end