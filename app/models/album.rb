class Album
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  belongs_to :user
  has_many :photos, dependent: :destroy

  def time
    self.created_at.to_formatted_s
  end

  def info_by_json
    album_info = {
      id:self.id.to_s,
      name: self.name,
      photos: photos.map{|photo| photo.info_by_json},
      created_at: self.time
    }
  end
end
