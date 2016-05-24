module Endpoints
  class Albums < Grape::API

    resource :albums do

      # Events API test
      # /api/v1/events/ping
      # results  'events endpoints'
      get :ping do
        { :ping => 'albums' }
      end

      # Create Album
      # POST: /api/v1/albums
      # parameters:
      #   token:      String *required
      #   name:       String *required
      # results:
      #   return album id
      post  do
        user = User.find_by_token params[:token]
        if user.present?
          album = Album.new(user:user, name:params[:name])
          if album.save()
            {:success => {album_id:album.id.to_s}}
          else
            {:failure => album.errors.messages}
          end
        else
          {:failure => "Please sign"}
        end
      end

      # Get Albums
      # GET: /api/v1/albums
      # parameters:
      #   token:      String *required
      # results:
      #   return albums
      get do
        user = User.find_by_token params[:token]
        if user.present?
            {:success => {albums:user.albums_by_json}}
        else
          {:failure => "Please sign"}
        end
      end

      # Get Album
      # GET: /api/v1/albums/get_album
      # parameters:
      #   token:      String *required
      #   album_id: String *required
      # results:
      #   return album photos
      get :get_album do
        user = User.find_by_token params[:token]
        if user.present?
            album = user.albums.find(params[:album_id])
            {:success => {album:album.info_by_json}}
        else
          {:failure => "Please sign"}
        end
      end

      # Upload Photo
      # POST: /api/v1/albums/upload_photo
      # parameters:
      #   token:      String *required
      #   album_id:   String *required
      #   photo:      String *required
      # results:
      #   return album id
      post :upload_photo do
        user = User.find_by_token params[:token]
        if user.present?
          photo = Photo.new(photo:params[:photo], album_id:params[:album_id])
          if photo.save()
            {:success => {photo_id:photo.id.to_s}}
          else
            {:failure => photo.errors.messages}
          end
        else
          {:failure => "Please sign"}
        end
      end

      # Get Photos
      # GET: /api/v1/albums/photos
      # parameters:
      #   token:      String *required
      #   album_id:   String *required
      # results:
      #   return album id
      get :photos do
        user = User.find_by_token params[:token]
        if user.present?
            album = Album.find(params[:album_id])
            {:success => {photos:album.photos.map{|photo| {id:photo.id.to_s,photo:photo.photo_url}}}}
        else
          {:failure => "Please sign"}
        end
      end

    end
  end
end
