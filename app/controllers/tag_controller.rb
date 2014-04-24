# encoding: utf-8
class TagController < ApplicationController
  def list 
    return render :json=>Tag.list_all
  end
end
