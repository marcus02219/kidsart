class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :album
  mount_uploader :photo, PhotoUploader

  field :name,              :type => String
  field :photo,         		:type => String

  def time
    self.created_at.to_formatted_s
  end
  def info_by_json
    {id:self.id.to_s, url:self.photo_url, uploaded_at:self.time, name: self.name==nil ? "" : self.name}
  end
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
