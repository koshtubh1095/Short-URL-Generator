class ShortUrlsController < ApplicationController
	skip_before_action :verify_authenticity_token
	
	def index
		@url = current_user.short_urls.new
		@urls = current_user.short_urls.all
	end

	def show
		redirect_to @url.sanitize_url
	end

	def create
		@url = current_user.short_urls.new
		@url.original_url = params[:original_url]
		@url.sanitize
		if @url.new_url?
			if @url.save
				redirect_to shortened_path(@url.short_url)
			else
				flash[:error] = "Please check the error."
				render 'index'
			end
		else
			flash[:error] = "Short link already exists for this url."
		end
	end

	def shortened
		@url = current_user.short_urls.find_by_short_url(params[:short_url])
		host = request.host_with_port
		@original_url = @url.sanitize_url
		@short_url = host + '/' + @url.short_url
	end

	def fetch_original_url
		fetch_url = current_user.short_urls.find_by_short_url(:params[:short_url])
		redirect_to fetch_url.sanitize_url
	end

	private
	def find_url
		@url = current_user.short_urls.find_by_short_url(params[:short_url])

	end

	def url_params
		params.require(:url).permit(:original_url)
	end
end

