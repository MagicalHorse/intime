class Ims::Assistant < Ims::Base

  def self.update_is_online(req, params = {})
    post(req, params.merge(path: 'assistant/combo_status_update'))
  end

  # 导购获取可选择礼品卡列表
  def self.all(req, params = {})
    post(req, params.merge(path: "assistant/gift_cards"))
  end
end