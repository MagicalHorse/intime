class ApiBaseController < ApplicationController
  include ISAuthenticate
  before_filter :auth_api, :only=>[:index]
end
