class HomeController < ApplicationController
	def about
		@contact = Contact.new
	end
	
	def terms
	end
	
	def privacy
	end
	
	def cookies_policy
	end
	
	def contact
		@contact = Contact.new
	end
	
	def post_contact
		
		if current_user
			@contact = current_user.contacts.build(contact_params)
		else
			@contact = Contact.new(contact_params)
		end
		@contact.image = params[:contact][:image]
		if @contact.save
			redirect_to contact_message_received_page_path
		else
			@name = params[:contact][:name]
			@email = params[:contact][:email]
			@content = params[:contact][:message]
			render :contact
		end
	end
	
	def contact_message_received
	end
	
	private
		def contact_params
			params.require(:contact).permit(:email, :image, :message, :name)
		end
	
end
