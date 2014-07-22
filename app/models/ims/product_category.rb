# encoding: utf-8
class Ims::ProductCategory < Ims::Base

  class << self
    def list(req, params={})
      post(req, params.merge(path: 'assistant/category_sizes'))
    end
  end

end
