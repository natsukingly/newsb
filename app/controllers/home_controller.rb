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
		
		@name = params[:contact][:name]
		@email = params[:contact][:email]
		@content = params[:contact][:message]
		if @contact.save
			ContactMailer.auto_reply(@name, @email, @content).deliver
			redirect_to contact_message_received_page_path
		else
			flash[:notice] = "Error. We couldn't process your message."
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
