# encoding: utf-8
module Alipay
  class Logger

    [:info, :debug, :warn, :error].each do |method|
      define_method(method) do |*args|
        puts args
      end
    end
  end
end
