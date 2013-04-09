class Resource < ActiveRecord::Base
  attr_accessible :domain, :height, :length, :name, :sortorder, :status, :type, :width
  belongs_to :source, :polymorphic=>true
  
end
