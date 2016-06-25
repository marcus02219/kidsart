module Endpoints
  class Accounts < Grape::API

    resource :accounts do

      # Accounts API test
      # /api/v1/accounts/ping
      # results  'gwangming'
      get :ping do
        { :ping => 'gwangming' }
      end

      # Reset Password
      # GET: /api/v1/accounts/forgot_password
      # parameters:
      #   email:      String *required
      # results:
      #   return album id
      get :forgot_password do
        user = User.where(email:params[:email]).first
        if user.present?
          user.send_reset_password_instructions
          {success: 'Email was sent successfully'}
        else
          {:failure => 'Cannot find your email'}
        end
      end

    end
  end
end
