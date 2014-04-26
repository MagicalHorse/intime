# encoding: utf-8
class ComboPic < ActiveRecord::Base
  attr_accessible :remote_id, :combo_id, :url

  belongs_to :combo
end
