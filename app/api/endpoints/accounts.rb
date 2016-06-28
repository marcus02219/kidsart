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
          # ses = AWS::SES::Base.new(
          #   :access_key_id     => 'AKIAIAVSQEQ4UGJZ6T6Q',
          #   :secret_access_key => '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',
          # )
          # verified_emails = ses.addresses.list.result
          # if verified_emails.include? user.email
          #   ses.send_email(
          #      :to        => [user.email],
          #      :source    => '"KidsArt" <noreply@kidsart.media>',
          #      :subject   => 'Forgot Password',
          #      :text_body => 'Internal text body'
          #   )
          # else
          #   ses.addresses.verify(user.email)
          # end


          user.send_reset_password_instructions
          {success: 'Email was sent successfully'}
        else
          {:failure => 'Cannot find your email'}
        end
      end

    end
  end
end
