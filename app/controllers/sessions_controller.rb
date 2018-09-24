class SessionsController < Devise::SessionsController
  def create
    super do
      @jwt = Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil).first if resource
    end
  end
end
