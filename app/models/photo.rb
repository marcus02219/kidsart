class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :album
  mount_uploader :photo, PhotoUploader

  field :photo,         		:type => String

  def photo_url
  	if self.photo.url.nil?
  		""
  	else
      if Rails.env.production?
        self.photo.url
      else
    		self.photo.url.gsub("#{Rails.root.to_s}/public/album/", "/album/")
      end
  	end
  end

end
