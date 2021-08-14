class TwitterAccountsController < ApplicationController
	
	before_action :require_user_logged_in!
	before_action :set_twitter_account, only: [:destroy]

	def index
		

		if Current.user.twitter_accounts.any?
			@twitter_accounts = Current.user.twitter_accounts
		else
			@twitter_accounts = []
			
		end
		
	end

	def destroy
		@twitter_account = Current.user.twitter_accounts.find(params[:id])
		@twitter_account.destroy
		redirect_to twitter_accounts_path, notice: "Sua conta foi desconectada com sucesso."
	end

	private

	def set_twitter_account
		@twitter_account = Current.user.twitter_accounts.find(params[:id])
	end
end