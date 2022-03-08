class UsersController < ApplicationController
  def index
    if !current_user
      render "devise/sessions/new"
    end
  end
end
