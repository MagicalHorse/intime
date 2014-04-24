# encoding: utf-8
class Resource < ActiveRecord::Base
  attr_accessible :domain, :height, :length, :name, :sortorder, :status, :type, :width
  belongs_to :source, :polymorphic=>true
  
  class<<self
    def absolute_url(resource)
      return '' if resource.nil?
      return PIC_DOMAIN + resource[:name]
    end
  end
end
