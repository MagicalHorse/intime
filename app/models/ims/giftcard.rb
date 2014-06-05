# encoding: utf-8
class Ims::Giftcard < Ims::Base

  # 默认礼品卡Id
  DEFAULT_ID = '1'

  # 导购获取可选择礼品卡列表
  def self.all(req, params = {})
    post(req, params.merge(path: "assistant/gift_cards"))
  end

  # 普通用户-已绑定卡的礼品卡概述（在API部门是否绑定）
  def self.my(req, params = {})
    post(req, params.merge(path: 'giftcard/my'))
  end

  # 普通用户通过手机号得到卡信息，同时进行绑定
  def self.bind(req, params = {})
    post(req, params.merge(path: 'giftcard/bind'))
  end

  # 判断手机号是否已经绑定（在集团信息部是否绑定）
  def self.isbind(req, params = {})
    post(req, params.merge(path: 'giftcard/isbind'))
  end

  def self.create(req, params = {})
    post(req, params.merge(path: 'giftcard/create'))
  end

  # 普通用户购买充值卡，列表
  def self.items(req, params = {})
    post(req, params.merge(path: 'giftcard/items'))
  end

  # 普通用户购买充值卡
  def self.transfer_detail(req, params = {})
    post(req, params.merge(path: 'giftcard/transfer_detail'))
  end

  # 获取礼品卡赠送信息 通过赠送记录 id
  def self.trans_detail2(req, params = {})
    post(req, params.merge(path: 'giftcard/trans_detail2'))
  end

  def self.detail(req, params = {})
    post(req, params.merge(path: 'giftcard/detail'))
  end

  def self.trans_detail(req, params = {})
    post(req, params.merge(path: 'giftcard/trans_detail'))
  end

  def self.receive(req, params = {})
    post(req, params.merge(path: 'giftcard/receive'))
  end

  def self.recharge(req, params = {})
    post(req, params.merge(path: 'giftcard/recharge'))
  end

  def self.send(req, params = {})
    post(req, params.merge(path: 'giftcard/send'))
  end

  def self.sendex(req, params = {})
    post(req, params.merge(path: 'giftcard/sendex'))
  end

  def self.changepwd(req, params = {})
    post(req, params.merge(path: 'giftcard/change_pwd'))
  end

  def self.resetpwd(req, params = {})
    post(req, params.merge(path: 'giftcard/reset_pwd'))
  end

  def self.refuse(req, params = {})
    post(req, params.merge(path: 'giftcard/refuse'))
  end

  def self.refusebytransid(req, params = {})
    post(req, params.merge(path: 'giftcard/refusebytransid'))
  end

  def self.list(req, params = {})
    post(req, params.merge(path: 'giftcard/list'))
  end

end
