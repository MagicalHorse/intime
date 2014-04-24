# encoding: utf-8
class UserRequest < ActiveRecord::Base
  attr_accessible :lastaction, :msg, :utoken,:lastpage
end

# The action type placeholder
class RequestAction
  # say hello to user
  ACTION_SAY_HELLO = 'SAY_HELLO'
  # cannot recognize keyword
  ACTION_NOT_REC = 'NOT_REC'
  # search point without binding card
  ACTION_JF_SEARCH_NB = 'JF_SEARCH_NB'
  # search point with binding card
  ACTION_JF_SEARCH_BD = 'JF_SEARCH_BD'
  # binding card after searching point
  ACTION_JF_BIND = 'JF_BIND'
  # search promotion first time
  ACTION_PRO_LIST_FT = 'PRO_LIST_FT'
  # search promotion more
  ACTION_PRO_LIST_MR = 'PRO_LIST_MR'
  # search product first time
  ACTION_PROD_LIST_FT = 'PROD_LIST_FT'
  # search product more
  ACTION_PROD_LIST_MR = 'PROD_LIST_MR'
  # exchange card point
  ACTION_EX_POINT = 'Exchange_Point'
  # intent to join custom activity
  ACTION_CUS_ACTIVITY = 'Customer_Activity'
end
