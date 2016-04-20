class Album
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  belongs_to :user
  has_many :photos

  def info_by_json
    album_info = {
      id:self.id.to_s,
      name: self.name,
      photos: photos.map{|photo| {id:photo.id.to_s,photo:photo.photo_url}}
    }
  end
end
