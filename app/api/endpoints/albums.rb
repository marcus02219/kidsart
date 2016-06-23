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
      post do
        user = User.find_by_token params[:token]
        if user.present?
          album = Album.new(user:user, name:params[:name])
          if album.save()
            {:success => {album_id:album.id.to_s}}
          else
            {:failure => album.errors.messages}
          end
        else
          {:failure => "Please sign in"}
        end
      end
      # Change Album name
      # POST: /api/v1/albums
      # parameters:
      #   token:        String *required
      #   album_id:     String *required
      #   name:         String *required
      # results:
      #   return album id
      put do
        user = User.find_by_token params[:token]
        if user.present?
          album = user.albums.find(params[:album_id])
          if album.update(name: params[:name])
            {:success => {album_id:album.id.to_s}}
          else
            {:failure => album.errors.messages}
          end
        else
          {:failure => "Please sign in"}
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
          {:failure => "Please sign in"}
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
          {:failure => "Please sign in"}
        end
      end

      # Delete Album
      # DELETE: /api/v1/albums
      # parameters:
      #   token:      String *required
      #   album_id:   String *required
      # results:
      #   return album id
      delete do
        user = User.find_by_token params[:token]
        if user.present? and user.albums.count > 0
          album = user.albums.find(params[:album_id])
          if album.present? and album.delete
            {:success => {album_id:album.id.to_s}}
          else
            {:failure => "Can't find album"}
          end
        else
          {:failure => "Please sign in"}
        end
      end

      # Upload Photo
      # POST: /api/v1/albums/upload_photo
      # parameters:
      #   token:      String *required
      #   album_id:   String *required
      #   photo:      String *required
      #   thumbnail:  String *required
      #   name:       String *optional
      # results:
      #   return album id
      post :upload_photo do
        user = User.find_by_token params[:token]
        if user.present?
          photo = Photo.new(photo:params[:photo], thumbnail:params[:thumbnail], album_id:params[:album_id], name:params[:name])
          if photo.save()
            {:success => photo.info_by_json}
          else
            {:failure => photo.errors.messages}
          end
        else
          {:failure => "Please sign in"}
        end
      end
      # Change Photo
      # POST: /api/v1/albums/change_photo
      # parameters:
      #   token:      String *required
      #   photo_id:   String *required
      #   photo:      String *required
      #   thumbnail:  String *required
      #   name:       String *optional
      # results:
      #   return album id
      post :change_photo do
        user = User.find_by_token params[:token]
        if user.present?
          photo = Photo.find(params[:photo_id])
          if photo.update(photo: params[:photo], thumbnail:params[:thumbnail], name: params[:name])
            {:success => photo.info_by_json}
          else
            {:failure => photo.errors.messages}
          end
        else
          {:failure => "Please sign in"}
        end
      end
      # Get Photos
      # GET: /api/v1/albums/photos
      # parameters:
      #   token:      String *required
      #   album_id:   String *required
      # results:
      #   return photo_list
      get :photos do
        user = User.find_by_token params[:token]
        if user.present?
            album = Album.find(params[:album_id])
            {:success => {photos:album.photos.map{|photo| photo.info_by_json}}}
        else
          {:failure => "Please sign in"}
        end
      end
      # Delete Photo
      # DELETE: /api/v1/albums/photo
      # parameters:
      #   token:      String *required
      #   photo_id:   String *required
      # results:
      #   return photo id
      delete :photo do
        user = User.find_by_token params[:token]
        if user.present? and user.albums.count > 0
          photo = Photo.find(params[:photo_id])
          if photo.delete
            {:success => {album_id:photo.id.to_s}}
          else
            {:failure => photo.errors.messages}
          end
        else
          {:failure => "Please sign in"}
        end
      end
    end
  end
end
