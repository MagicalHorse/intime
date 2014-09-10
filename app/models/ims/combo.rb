# encoding: utf-8
class Ims::Combo < Ims::Base

  class << self
    def list(req, params={})
      post(req, params.merge(path: 'assistant/combos'))
    end

    def create(req, params={})
      post(req, params.merge(path: 'combo/create', content_type: :json))
    end

    def show(req, params = {})
      post(req, params.merge(path: 'combo/detail'))
    end

    def update(req, params = {})
      post(req, params.merge(path: 'combo/update', content_type: :json))
    end

    def upload_img(req, params ={})
      post(req, params.merge(path: 'resource/upload'))
    end

    def online_num(req, params = {})
      post(req, params.merge(path: 'assistant/combos_online_count'))
    end

    def delete(req, params = {})
      post(req, params.merge(path: 'combo/delete'))
    end

  end

end
