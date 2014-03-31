class Ims::Assistant < Ims::Base

  def self.update_is_online(req, params = {})
    post(req, params.merge(path: 'ims/assistant/combo_status_update'))
  end
end