module Endpoints
  class Events < Grape::API

    resource :events do

      # Events API test
      # /api/v1/events/ping
      # results  'events endpoints'
      get :ping do
        { :ping => 'events ednpoints' }
      end

      
    end
  end
end
