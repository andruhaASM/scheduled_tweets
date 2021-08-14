class OmniauthCallbacksController < ApplicationController
	before_action :require_user_logged_in!
	def twitter
		if Current.user.twitter_accounts.any?

			twitter_account = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
			twitter_account.update(
				name:auth.info.name,
				username: auth.info.nickname,
				image: auth.info.image,
				token: auth.credentials.token,
				secret: auth.credentials.secret,
				)
			redirect_to twitter_accounts_path, notice: "Conta do twitter conectada com sucesso!"
		else # If there is no twitter account associated
			
			TwitterAccount.create(user_id: Current.user[:id],username: auth.info.nickname, name:auth.info.name,
				image: auth.info.image,
				token: auth.credentials.token,
				secret: auth.credentials.secret, ) 
			redirect_to twitter_accounts_path, notice: "Conta do twitter conectada com sucesso!"
		end

	end
	def auth
		request.env["omniauth.auth"]
	end
end