# encoding: utf-8
class Ims::Assistant < Ims::Base

  def self.update_is_online(req, params = {})
    post(req, params.merge(path: 'assistant/combo_status_update'))
  end

  def self.brands(req, params={})
    post(req, params.merge(path: 'assistant/brands'))
  end

end
