class Mini::Assistant < Mini::Base

  def self.update_is_online(req, params = {})
    post(req, params.merge(path: 'assistant/combo_status_update'))
  end

end