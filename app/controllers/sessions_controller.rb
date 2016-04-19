class SessionsController < Devise::SessionsController
	def new
		super
	end

	protected
	def verified_request?
		request.content_type == "application/json" || super
	end
end
