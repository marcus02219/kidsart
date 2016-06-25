class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :first_name,         type: String, default: ""
  field :last_name,          type: String, default: ""
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  field :from_social,               :type => String,    :default => ""     # Social login status


  #field :access_token,              :type => String
  field :user_auth_id,              :type => String

  acts_as_token_authenticatable
  field :authentication_token,      :type => String

  has_many :albums, dependent: :destroy

  def name
    [self.first_name, self.last_name].join(" ")
  end
  def self.find_by_token(token)
    User.where(:authentication_token=>token).first
  end

  def info_by_json
    user = self
    user_info={
      id:user.id.to_s,
      first_name:user.first_name == nil ? "" : user.first_name,
      last_name:user.last_name == nil ? "" : user.last_name,
      email:user.email,
      auth_id:user.user_auth_id == nil ? "" : user.user_auth_id,
      token:user.authentication_token,
      social:user.from_social == nil ? "" : user.from_social
    }
  end

  def albums_by_json
    album_list = [];
    self.albums.each do |album|
      album_list << {
        id:album.id.to_s,
        name:album.name,
        photos:album.photos.map{|photo| photo.info_by_json},
        created_at:album.time
      }
    end
    album_list
  end
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  def send_password_reset
    generate_token(:reset_password_token)
    self.reset_password_token = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
end
