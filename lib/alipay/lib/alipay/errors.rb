# encoding: utf-8
module Alipay
  class BaseError             < StandardError; end
  class RequestError          < BaseError;     end
  class SignVerifyError       < BaseError;     end
  class RequiredArgumentError < BaseError;     end
end
