# encoding: utf-8
class Ims::ProductCoding < Ims::Base

  class << self
    def list(req, params={})
      post(req, params.merge(path: 'assistant/salescodes'))
    end

    def create(req, params={})
      post(req, params.merge(path: 'assistant/salescode_add'))
    end
  end

end
