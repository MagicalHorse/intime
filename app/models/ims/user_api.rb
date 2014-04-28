# encoding: utf-8
class Ims::UserApi < Ims::Base

  def self.favor(req, params = {})
    post(req, params.merge(path: "user/favor"))
  end

  def self.unfavor(req, params = {})
    post(req, params.merge(path: "user/unfavor"))
  end

  def self.favor_store(req, params = {})
    post(req, params.merge(path: "user/favor_store"))
  end

  def self.favor_combo(req, params = {})
    post(req, params.merge(path: "user/favor_combo"))
  end

  def self.latest_giftcard(req, params = {})
    post(req, params.merge(path: 'user/latest_giftcard'))
  end

end
