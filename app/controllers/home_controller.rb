class HomeController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token
  def index
  end
  # Create account API
  # POST: /api/v1/accounts/create
  # parameters:
  #   email:          String *required
  #   password:       String *required minimum 6
  #   first_name:     String *required
  #   last_name:      String *required
  #   from_social:    String *required
  # results:
  #   return created user info
  def create
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'

    email        = params[:email].downcase    if params[:email].present?
    password     = params[:password].downcase    if params[:password].present?
    from_social  = params[:social].downcase   if params[:social].present?
    first_name   = params[:first_name]
    last_name    = params[:last_name]

    if User.where(email:email).first.present?
      render json:{failure: 'This email already exists. Please try another email'} and return
    end
    user = User.new(email:email, password:params[:password], first_name:first_name, last_name:last_name, from_social:from_social)
    if user.save
      if sign_in(:user, user)
        render :json => {:success => user.info_by_json}
      else
        render json: {:failure => 'cannot login'}
      end
    else
      render :json => {:failure => user.errors.messages}
    end
  end
  # Destroy account API
  # POST: /api/v1/accounts/destroy
  # parameters:
  #   token:      String *required
  # results:
  #   return success string
  def destroy
    user   = User.find_by_token params[:token]
    if user.present?
      if user.destroy
        sign_out(resource)
        render :json => {:success => 'deleted account'}
      else
        render :json => {:failure => "cannot delete this user"}
      end
    else
      render :json => {:failure => "cannot find user"}
    end
  end
  # Login API
  # POST: /api/v1/accounts/sign_in
  # parameters:
  #   email:      String *required
  #   password:   String *required
  # results:
  #   return user_info
  def create_session
    if params[:social]
      social_sign_in(params)
    end
    email    = params[:email]
    password = params[:password]

    resource = User.find_for_database_authentication( :email => email )
    if resource.nil?
      render :json => {faild:'No Such User'}, :status => 401
    else
      if resource.valid_password?( password )
        user = sign_in( :user, resource )
        render :json => {:success => resource.info_by_json}
        else
          render :json => {faild: "Password is wrong"}, :status => 401
        end
      end
   end

   # LogOut API
   # POST: /api/v1/accounts/sign_out
   # parameters:
   #   email:      String *required
   # results:
   #   return user_info
   def delete_session
    if params[:email].present?
        resource = User.find_for_database_authentication(:email => params[:email])
    elsif params[:user_id].present?
      resource = User.find(params[:user_id])
    end

    if resource.nil?
       render :json => {faild:'No Such User'}, :status => 401
    else
    sign_out(resource)
       render :json => {:success => 'sign out'}
    end
  end
  # Login API using social
  # POST: /api/v1/accounts/social_sign_in
  # parameters:
  #   email:        String *required
  #   social:       String *required
  #   toke:         String *required
  #   first_name:   String *required
  #   last_name:    String *required
  # results:
  #   return user_info

  def social_sign_in
    if params[:token].present?
      email        = params[:email].downcase    if params[:email].present?
      from_social  = params[:social].downcase   if params[:social].present?
      token        = params[:token]
      password     = params[:token][0..10]
      first_name   = params[:first_name]
      last_name    = params[:last_name]

      puts "f_name -> #{first_name}"

      user = User.any_of({:email=>email}).first
      if user.present?
        user.update(first_name: first_name, last_name: last_name, user_auth_id: token)
        if sign_in(:user, user)
          render json: {:success => user.info_by_json}
        else
          render json: {:failure => 'cannot login'}
        end
      else
          user = User.new(
              email:email,
              user_auth_id:token,
              password:password,
              first_name:first_name,
              last_name:last_name,
              from_social:from_social,
              )
          puts "uf_name->#{user.first_name}"
        if user.save
          if sign_in(:user, user)
            render json: {:success => user.info_by_json}
          else
            render json: {:failure => 'cannot login'}
          end
        else
          render :json => {:failure => user.errors.messages}
        end
      end
    end
  end

end
