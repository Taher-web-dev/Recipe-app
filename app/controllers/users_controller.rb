class UsersController < ApplicationController
  def index
    render "devise/sessions/new"
  end
end
