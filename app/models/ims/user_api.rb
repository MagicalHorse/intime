# encoding: utf-8
class Ims::UserApi < Ims::Base

  def self.favor(req, params = {})
    post(req, params.merge(path: "ims/user/favor"))
  end

  def self.unfavor(req, params = {})
    post(req, params.merge(path: "ims/user/unfavor"))
  end

  def self.favor_store(req, params = {})
    post(req, params.merge(path: "ims/user/favor_store"))
  end

  def self.favor_combo(req, params = {})
    post(req, params.merge(path: "ims/user/favor_combo"))
  end

end